class CoursesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  def index
  # @courses= Course.all.order("created_at DESC")
   #@course=Course.new
   #instructor_id = current_user.id
   #@instructor = Instructor.find(instructor_id)
    
  end

  def new
    @course=Course.new
    #instructor_id = current_user.id
    #@instructor = Instructor.find(instructor_id)
    
    #@course = @instructor.courses.new()
   # @course= current_user.courses.build
  end

  def create
    #byebug
  #  @course = current_user.courses.create(course_params)
  instructor_id = current_user.id
  @instructor = Instructor.find(instructor_id)
  #@course = @instructor.courses.new(course_params)
  
  @course = current_user.courses.build(course_params)
  
  
    #@course=Course.new(course_params)
    # @course.instructor_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to instructor_path(@instructor), notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end 
    end
  end

  def edit
  end

  def destroy
  end

  def show

  end

  private

    def course_params
      params.require(:course).permit(:title, :description, :fileupload)
    end
end
