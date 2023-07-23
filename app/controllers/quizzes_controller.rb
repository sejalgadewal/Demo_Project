class QuizzesController < ApplicationController
  def index
  end
 def show
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @quiz = @lecture.quiz
  end

  def edit
  end

  def destroy
  end

  
def new
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    if @lecture.quiz.present?
      redirect_to course_lecture_quiz_path(@course, @lecture, @lecture.quiz), notice: 'Quiz was already created.'
    else
    @quiz = @lecture.build_quiz
    @quiz.questions.build
    end
  end

  def create
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @quiz = @lecture.build_quiz(quiz_params)

    if @quiz.save
      redirect_to course_lecture_path(@course, @lecture), notice: 'Quiz was successfully created.'
    else
      render :new
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, questions_attributes: [:id, :content, :_destroy])
  end

 end
