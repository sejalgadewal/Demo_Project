class Lecture < ApplicationRecord
    belongs_to :course
    belongs_to :user
    validates :video, presence: { message: 'must be attached' }
    has_one_attached :video
    has_one :quiz, dependent: :destroy
    accepts_nested_attributes_for :quiz
end


