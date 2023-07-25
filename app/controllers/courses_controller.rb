class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @courses=Course.all
   
    if current_user.role == "Instructor"
      render partial: 'instructorprofile'
    elsif current_user.role == "Student"
      @user=User.where(role: "Instructor")
    end

  end

  def new
    @course=Course.new
    # @course.course_files.build 
  end

  def create
    

    instructor_id = current_user.id
    @instructor = Instructor.find(instructor_id)
  
    @course = current_user.courses.build(course_params)
    
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
    instructor_id = current_user.id
    @instructor = Instructor.find(instructor_id)
  
    if @course.update(course_params)
      redirect_to courses_mycourse_path, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
   end




  def destroy
    # instructor_id = current_user.id
    # @instructor = Instructor.find(instructor_id)
     @course.destroy
    redirect_to courses_mycourse_path, notice: "Course was successfully destroyed."    
  end

  def show
    @course=Course.find(params[:id])
    @user=User.where(role: "Instructor")
    @lectures=@course.lectures
  
  end

  def mycourse
    @courses = current_user.courses
   @lectures=current_user.lectures
   # @lectures=@courses.lectures
  end
  private

    def course_params
      params.require(:course).permit(:title, :description, documents: [])
    end
    def set_course
      @course=Course.find(params[:id])
    end
end
