class PaymentsController < ApplicationController
    before_action :authenticate_user!

    def payment_page
      @course = Course.find(params[:course_id])
      #@payment_intent= params[:payment_intent_id]
      #Stripe::PaymentIntent= params[:payment_intent_id]
       @payment_intent = Stripe::PaymentIntent.create(
         amount: (@course.price * 100).to_i,
         currency: 'usd',
         description: 'Course Enrollment: ' + @course.title,
         #automatic_payment_methods[allow_redirects],
    )
    end

    def payment_process
        @course = Course.find(params[:course_id])
         card_token = params[:token]

    begin
      payment_intent = Stripe::PaymentIntent.create(
        amount: (@course.price * 100).to_i,
        currency: 'usd',
        description: 'Course Enrollment: ' + @course.title,
        automatic_payment_methods: {enabled: true},
        #confirm: true , 
        #return_url: payment_confirmation_url,
         
        confirm: true
        # capture_method: 'manual',
      )
        payment_intent = Stripe::PaymentIntent.update(payment_intent.id, {
          payment_method_types: ['card'],
          automatic_payment_methods: {enabled: true},
        })  

      flash[:notice] = 'Payment Intent created. Please complete the payment.'
      redirect_to payment_intent.client_secret, allow_other_host: true , notice: "Payment success"
    rescue Stripe::StripeError => e
      flash[:error] = 'Payment failed: ' + e.message
      redirect_to course_path(@course), notice: "payment failed"
    end
  end

  def confirm_payment
    payment_intent_id = params[:payment_intent_id]

    begin
      payment_intent = Stripe::PaymentIntent.confirm(
        payment_intent_id ,
        {payment_method: 'pm_card_visa'},
      )
      enrollment = current_user.enrollments.find_by(course_id: @course.id)
      enrollment.update(payment_status: 'paid')

      flash[:notice] = 'Payment successful! You are now enrolled in the course.'
      redirect_to course_path(@course)
    rescue Stripe::StripeError => e
      flash[:error] = 'Payment confirmation failed: ' + e.message
      redirect_to course_path(@course)
    end
  end

end
