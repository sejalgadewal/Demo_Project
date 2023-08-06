class Api::V1::QuestionsController < ApplicationController
  before_action :set_quiz
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @questions = @quiz.questions
    render json: @questions
  end

  def create
    @question = @quiz.questions.build(question_params)
    authorize! :manage, @question

    if @question.save
      render json: { message: 'Question successfully created.' }
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @question = @quiz.questions.find(params[:id])
    authorize! :manage, @question

    if @question.update(question_params)
      render json: { message: 'Question successfully updated.' }
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @question = @quiz.questions.find(params[:id])
    authorize! :manage, @question

    if @question.destroy
      render json: { message: 'Question successfully destroyed.' }
    else
      render json: { errors: @question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:content, :answer1, :answer2, :answer3, :answer4, :correct)
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end
end
