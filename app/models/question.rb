class Question < ApplicationRecord
	belongs_to :quiz
	validates :content, presence: true
	#has_many :answers, dependent: :destroy
	#accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
