class QuizzesController < ApplicationController
  def index
  end
  def show
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @quiz = @lecture.quiz
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @quiz=Quiz.find(params[:id])
    @quiz.destroy
    redirect_to course_mylecture_path(@course), notice: "Lecture was successfully destroyed."
  end

  def myquiz
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    if @lecture.quiz.present?
      @quiz = @lecture.quiz  
     else
      redirect_to course_mylecture_path(@course), notice: 'No any quiz created....please create any quiz .'
    end
  end

  def new
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    if @lecture.quiz.present?
      # redirect_to course_lecture_quiz_path(@course, @lecture, @lecture.quiz), notice: 'Quiz was already created.'
      redirect_to course_lecture_myquiz_path(@course, @lecture), notice: 'Quiz was already created.' 
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
      #redirect_to course_lecture_path(@course, @lecture), notice: 'Quiz was successfully created.'
      redirect_to course_lecture_myquiz_path(@course, @lecture), notice: 'Quiz was successfully created.'
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    @quiz=Quiz.find(params[:id])
   # @quiz= @lecture.quiz.find(params[:quiz_id])
    # if @quiz.present?
    #   # @quiz = @lecture.build_quiz
    #    @quiz.questions.update(quiz_params)
    # end
  end

  def update
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:lecture_id])
    #@quiz = @lecture.update_quiz(quiz_params)
    @quiz=@lecture.quiz
    @quiz.update(quiz_params)
    #@quiz.questions.update(quiz_params)
    if @quiz.save
      #redirect_to course_lecture_path(@course, @lecture), notice: 'Quiz was successfully created.'
      redirect_to course_lecture_myquiz_path(@course, @lecture), notice: 'Quiz was successfully updated.'
    else
      render :edit
    end
  end

  private

  def quiz_params
    params.require(:quiz).permit(:title, questions_attributes: [:id, :content, :_destroy],answers_attributes: [:id, :content, :correct, :_destroy] )
  end
 end
