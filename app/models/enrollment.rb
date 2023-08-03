class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_one :payment
  
  validates :user_id, uniqueness: { scope: :course_id, message: "has already enrolled in this course" }
  default_scope { order(enrollment_date: :asc) }
  attr_accessor :payment_status

   # enum status: [:pending, :processing, :failed, :succeed]
    
end
