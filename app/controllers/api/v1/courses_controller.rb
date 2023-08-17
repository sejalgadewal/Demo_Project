class Api::V1::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :create]
  before_action :authenticate_user!, except: [:index]

  def index
    courses = Course.all
    @user=User.where(role: "Instructor")
    render json: { user: @user, courses: courses }, status: :ok
  end


  def show
    lectures = @course.lectures
    render json: { course: @course, lectures: lectures }, status: :ok
  end

  def create
    @course = current_user.courses.build(course_params)
    authorize! :manage, @course

    if @course.save
      students = User.where(role: "Student")
      students.each do |student|
        CourseMailer.send_lecture_email(student, @course).deliver_now
      end

      render json: @course, status: :created
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @course = Course.find(params[:id])
    authorize! :manage, @course

    if @course.update(course_params)
      render json: @course, status: :ok
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @course = Course.find(params[:id])
    authorize! :manage, @course

    @course.destroy
    head :no_content
  end

  def mycourses
    courses = current_user.courses.paginate(page: params[:page], per_page: 5)
    lectures = current_user.lectures
    render json: { courses: courses, lectures: lectures }, status: :ok
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, documents: [])
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
