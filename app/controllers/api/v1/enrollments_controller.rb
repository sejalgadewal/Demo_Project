class Api::V1::EnrollmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @enrollments = current_user.enrollments
    render json: @enrollments
  end

  def create
    @course = Course.find(params[:course_id])
    @enrollment = current_user.enrollments.build(course: @course, enrollment_date: Date.today)
    
    if @enrollment.save
      render json: { message: 'Successfully enrolled in the course.' }
    else
      render json: { error: 'You are already enrolled in this course.' }, status: :unprocessable_entity
    end
  end
end
