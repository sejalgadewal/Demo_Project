class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
    
  validates :user_id, uniqueness: { scope: :course_id, message: "has already enrolled in this course" }
  
  default_scope { order(enrollment_date: :asc) }
  
end
