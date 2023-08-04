class Quiz < ApplicationRecord
	belongs_to :lecture
	has_many :questions, dependent: :destroy
	#accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: {message: "Title cant be blank ..."}, length: { maximum: 100 }
end
