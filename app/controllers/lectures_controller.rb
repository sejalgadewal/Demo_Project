class LecturesController < ApplicationController
  #before_action :authenticate_user!

  def index
    @course=Course.find(params[:course_id])
    @lectures= @course.lectures
  end

  def new
    @course=Course.find(params[:course_id])
    @lecture=@course.lectures.build
  end

  def create
    @course=Course.find(params[:course_id])
    @lecture=@course.lectures.build(lecture_params)
    @lecture.user = current_user

    if @lecture.save
      redirect_to course_lectures_path(@course), notice: 'Lecture was successfully created .'
    else
        render :new
    end

  end

  def edit
  end

  def update
  end

  def show
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
    @quiz = @lecture.quiz
  end

  def destroy
  
  end

  def mylecture
    @course = Course.find(params[:course_id])
    @lectures= @course.lectures
  
  end

  def lecture_params
    params.require(:lecture).permit(:video)
  end
end
