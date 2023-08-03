class CheckoutsController < ApplicationController
    #byebug
    def create
        course=Course.find(params[:id])
        session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
            price_data: {
            #name: course.title,
            unit_amount: course.price * 100,
            currency: "inr",
            product_data: {
                name: course.title
            }
        },
            quantity: 1
        }],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
      respond_to do |format|
        format.js 
      end
    end
end
