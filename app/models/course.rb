class Course < ApplicationRecord
    belongs_to :user
   # belongs_to :instructor, class_name: 'User'
   has_many_attached :documents

  # validate :check_file_type

  private

  def check_file_type
    if documents.attached? && !documents.content_type.in?(%i(application/pdf))
      documents.purge # delete the uploaded file
      errors.add(:documents, 'Must be a PDF or a DOC file')
    end
  end

end
