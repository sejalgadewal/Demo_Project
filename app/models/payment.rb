class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :enrollment
  belongs_to :course
end
