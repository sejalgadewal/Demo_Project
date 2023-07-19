class Course < ApplicationRecord
    belongs_to :user
   # belongs_to :instructor, class_name: 'User'
   has_one_attached :fileupload

end
