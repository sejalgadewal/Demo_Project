class EnrollmentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def index
        @enrollments =current_user.enrollments
        @courses = Course.enrolled_by_student(current_user.id)
        #@courses=Course.joins(:enrollments).where("enrollments.user_id = ?",current_user.id)
    end

    def new
        @course = Course.find(params[:course_id])
        @enrollment =Enrollment.new
    end

    def create
        @course = Course.find(params[:course_id])
        #byebug
        #if Enrollment.pluck(:course_id).include?(@course.id) && Enrollment.pluck(:user_id).include?(current_user.id)
        @enrollment = current_user.enrollments.build(course: @course, enrollment_date: Date.today)
        if @enrollment.save
             #redirect_to @course, notice: 'Successfully enrolled in the course.'
            #redirect_to new_course_payment_path(@course) #, notice: 'Successfully enrolled in the course.'
            redirect_to payment_page_path(course_id: @course.id) , notice: 'Successfully enrolled in the course.'
            

        else
            #redirect_to course_path(@course), alert: 'You are already enrolled in this course .'
            flash[:error] = 'Failed to enroll '
            render :new
        end
    end

    def show
        @enrollment=Enrollment.find(params[:id])  
    end

    private

    def enroll_params
        params.require(:enrollment).permit(:course_id,:user_id)
    end
end
