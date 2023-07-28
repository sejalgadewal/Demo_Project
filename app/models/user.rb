class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  enum role: {Instructor: 0, Student: 1}
  has_many :enrollments, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :lectures, dependent: :destroy
  has_many :messages
  validates_uniqueness_of :name
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
end

