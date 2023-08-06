class Api::V1::QuizzesController < ApplicationController
  before_action :set_quiz
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    render json: @quiz
  end

  def create
    @quiz = @lecture.build_quiz(quiz_params)
    authorize! :manage, @quiz

    if @quiz.save
      render json: @quiz
    else
      render json: { errors: @quiz.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize! :manage, @quiz

    if @quiz.update(quiz_params)
      render json: @quiz
    else
      render json: { errors: @quiz.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :manage, @quiz

    if @quiz.destroy
      render json: { message: 'Quiz successfully destroyed.' }
    else
      render json: { errors: @quiz.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title)
  end

  def set_quiz
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @quiz = @lecture.quiz
  end
end
