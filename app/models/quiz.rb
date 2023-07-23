class Quiz < ApplicationRecord
	belongs_to :lecture
	has_many :questions, dependent: :destroy
    accepts_nested_attributes_for :questions, allow_destroy: true

end
