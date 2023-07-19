class InstructorsController < ApplicationController

  def index
    @instructors=Instructor.all
  end
  def new
    @instructor = Instructor.new
  end
  def show
    @instructor = Instructor.find(params[:id])
    @courses = @instructor.courses
  end
end
