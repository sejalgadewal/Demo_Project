class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  enum role: {Instructor: 0, Student: 1}
  has_many :enrollments, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :lectures, dependent: :destroy
  
end

