class LecturesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
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
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
    # authorize! :manage, @lecture
   
    if @lecture.update(lecture_params)
      redirect_to course_lectures_path(@course), notice: "Lecture was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
    @quiz = @lecture.quiz
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lecture = @course.lectures.find(params[:id])
    @lecture.destroy
    redirect_to course_lectures_path(@course), notice: "Lecture was successfully destroyed."    
  
  end

  def mylecture
    @course = Course.find(params[:course_id])
    @lectures= @course.lectures
  
  end

  def lecture_params
    params.require(:lecture).permit(:video)
  end
end
