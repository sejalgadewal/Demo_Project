class CoursesController < ApplicationController
  def index
  end

  def new
    @course= Course.new
  end

  def create
    @course = current_user.courses.create(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to root_url(@course), notice: "Course was successfully created." }
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
      params.require(:course).permit(:title, :description)
    end
end
