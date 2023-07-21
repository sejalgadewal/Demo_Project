class EnrollmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index

  end

  def new
    @course = Course.find(params[:course_id])
    @enrollment =Enrollment.new
  end

  def create
     @course = Course.find(params[:course_id])
     #id=current_user.enrollments.pluck(:course_id)
     
     
     ##if @course.enrollments.include?(current_user)

     #if Enrollment.pluck(:course_id).include?(@course.id) && Enrollment.pluck(:user_id).include?(current_user.id)
      #if Enrollment.select(:course_id, :user_id).include?(@course.id && current_user.id )
     
     #if Enrollment.select(:course_id,:user_id).include?(current_user.id && @course) 
     #a = Enrollment.all.pluck(:id)
      #if a.include? current_user.id && @course
      ## redirect_to @course, alert: 'You are already enrolled in this course.'

      ##else
        @enrollment = current_user.enrollments.build(course: @course)
        if @enrollment.save
          redirect_to @course, notice: 'Successfully enrolled in the course.'
        else
          redirect_to courses_path, alert: 'You are already enrolled in this course .'
        end
      ##end

  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def enroll_params
    params.require(:enrollment).permit(:course_id,:user_id)
  end
end
