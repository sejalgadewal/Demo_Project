class QuizzesController < ApplicationController
  before_action :set_quiz
  def show
    @quiz=Quiz.find(params[:id])
  end

  def destroy
    @quiz=Quiz.find(params[:id])
    authorize! :manage, @quiz
    @ques.destroy
    redirect_to course_mylecture_path(@course), notice: "Question was successfully destroyed."
  end

  def myquiz
    if @lecture.quiz.present?
      @quiz = @lecture.quiz  
    else
      redirect_to course_mylecture_path(@course), notice: 'No any quiz created....please create any quiz .'
    end
  end

  def new
    @quiz=@lecture.quiz
    if @quiz.present?
      # redirect_to course_lecture_quiz_path(@course, @lecture, @lecture.quiz), notice: 'Quiz was already created.'
      redirect_to course_lecture_quiz_path(@course,@lecture,@quiz), notice: 'Quiz was already created.' 
    else
      @quiz = @lecture.build_quiz
    end
  end

  def create
    @quiz = @lecture.build_quiz(quiz_params)
    authorize! :manage, @quiz
    if @quiz.save
    #  redirect_to course_lecture_myquiz_path(@course, @lecture), notice: 'Quiz was successfully created.'
      redirect_to course_lecture_quiz_path(@course,@lecture,@quiz)  
    else
      render :new
    end
  end

  def edit
    @quiz=Quiz.find(params[:id])
  end

  def update
    @quiz=@lecture.quiz
    authorize! :manage, @quiz
    @quiz.update(quiz_params)
    if @quiz.save
      redirect_to course_lecture_myquiz_path(@course, @lecture), notice: 'Quiz was successfully updated.'
    else
      render :edit
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title )
  end
  def set_quiz
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])  
  end

 end
