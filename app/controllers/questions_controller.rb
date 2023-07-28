class QuestionsController < ApplicationController
  before_action :set_question
  def index
    @questions = @quiz.questions 
    @lecture=@quiz.lecture
    @course=@lecture.course
  end

  def destroy
    @question=@quiz.questions.find(params[:id])
    authorize! :manage, @question
    @question.destroy
    redirect_to quiz_questions_path(@quiz), notice: "Question was successfully Destroyed."
  end

  def new
    @question=@quiz.questions.new
    @lecture=@quiz.lecture
    @course=@lecture.course 
  end

  def create
    @question=@quiz.questions.create(question_params)
    authorize! :manage, @question
    if @question.save
      redirect_to quiz_questions_path(@quiz), notice: 'Question Successfully created'
    else
      render :new
    end
  end

  def edit
    @question=@quiz.questions.find(params[:id])
    @lecture=@quiz.lecture
    @course=@lecture.course
  end

  def update
    @question=@quiz.questions.find(params[:id])
    authorize! :manage, @question
    if @question.update(question_params)
      redirect_to quiz_questions_path(@quiz), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  private

  def question_params
    params.require(:question).permit(:quiz_id, :content, :answer1, :answer2, :answer3, :answer4, :correct )
  end
  def set_question
    @quiz= Quiz.find(params[:quiz_id])
  end
end
