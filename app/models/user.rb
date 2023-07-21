class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
 #roles = %w[Student Instructor].freeze
  #self.inheritance_column = :type

# def self.roles
#     %w[Student Instructor] # Replace with your actual role names
#   end

  #validates :type, inclusion: { in: roles }
  enum role: {Instructor: 0, Student: 1}
 # validates :role, inclusion: {in: roles.keys }
  has_many :enrollments
  has_many :courses, dependent: :destroy
  
  
end

