class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :validatable

  enum role: {Instructor: 0, Student: 1}


  has_many :enrollments, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :lectures, dependent: :destroy
  has_many :messages, dependent: :destroy

  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to "users" }
  
  scope :by_role, -> (role) { where(role: role) }

  validates :name, presence: true
  validates :username, presence: true 

  serialize :attempted_quizzes, Array

  def quiz_attempted?(quiz)
    attempted_quizzes.include?(quiz.id)
  end

  def mark_quiz_attempted(quiz)
    attempted_quizzes << quiz.id
    save
  end
end

