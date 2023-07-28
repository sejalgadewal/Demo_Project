class LecturesController < ApplicationController
  before_action :set_course
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @lectures= @course.lectures
  end

  def new
    @lecture=@course.lectures.build
  end

  def create
    @lecture=@course.lectures.build(lecture_params)
    @lecture.user = current_user
    if @lecture.save
      # redirect_to course_lectures_path(@course), notice: 'Lecture was successfully created .'
      redirect_to course_mylecture_path, notice: "Lecture was successfully updated."
    else
      render :new
    end
  end

  def edit
    @lecture = @course.lectures.find(params[:id])
  end

  def update
    @lecture = @course.lectures.find(params[:id])
    if @lecture.update(lecture_params)
      # redirect_to course_lectures_path(@course), notice: "Lecture was successfully updated."
      redirect_to course_mylecture_path, notice: "Lecture was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def show
    @lecture = @course.lectures.find(params[:id])
    @quiz = @lecture.quiz
  end

  def destroy
    @lecture = @course.lectures.find(params[:id])
    @lecture.destroy
    redirect_to course_lectures_path(@course), notice: "Lecture was successfully destroyed."    
  
  end

  def mylecture
    @lectures= @course.lectures
  
  end

  private
  def lecture_params
    params.require(:lecture).permit(:video)
  end
  def set_course
    @course = Course.find(params[:course_id])
  end
end
