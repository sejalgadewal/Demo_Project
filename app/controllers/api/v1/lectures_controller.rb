class Api::V1::LecturesController < ApplicationController
  before_action :set_course
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @lectures = @course.lectures
    render json: @lectures
  end

  def create
    @lecture = @course.lectures.build(lecture_params)
    @lecture.user = current_user

    if @lecture.save
      render json: { message: 'Lecture was successfully created.' }
    else
      render json: { errors: @lecture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @lecture = @course.lectures.find(params[:id])

    if @lecture.update(lecture_params)
      render json: { message: 'Lecture was successfully updated.' }
    else
      render json: { errors: @lecture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @lecture = @course.lectures.find(params[:id])
    @quiz = @lecture.quiz
    render json: { lecture: @lecture, quiz: @quiz }
  end

  def destroy
    @lecture = @course.lectures.find(params[:id])
    @lecture.destroy
    render json: { message: 'Lecture was successfully destroyed.' }
  end

  private

  def lecture_params
    params.require(:lecture).permit(:video)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
