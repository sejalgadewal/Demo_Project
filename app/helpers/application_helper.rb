module ApplicationHelper
def total_enrolled_students(course)
    course.enrollments.count
  end

end
