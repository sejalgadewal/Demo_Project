class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @courses=Course.all
    @user=User.where(role: "Instructor")
  end

  def new
    @course=Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    authorize! :manage, @course
    if @course.save
      redirect_to courses_mycourse_path, notice: "Course was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end 
    students = User.where(role: "Student")
    students.each do |student|
      CourseMailer.send_lecture_email(student, @course).deliver_now
    end
  end

  def edit
  end

  def update
    authorize! :manage, @course
    if @course.update(course_params)
      redirect_to courses_mycourse_path, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    authorize! :manage, @course
    @course.destroy
    redirect_to courses_mycourse_path, notice: "Course was successfully destroyed."    
  end

  def show
    @user=User.where(role: "Instructor")
    @lectures=@course.lectures 
  end

  def mycourse
    @courses = current_user.courses.paginate(page: params[:page], per_page: 5)
    #@courses = current_user.courses
    @lectures=current_user.lectures
  end
 
  private
  def course_params
    params.require(:course).permit(:title, :description, documents: [])
  end
  def set_course
    @course=Course.find(params[:id])
  end
end
