class CourseMailer < ApplicationMailer
  def send_lecture_email(student, course)
    @student = student
    @course = course
    mail(to: @student.email, subject: "New Lecture Available in title :- #{@course.title} and description :- #{@course.description}")
  end
end
