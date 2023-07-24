class Course < ApplicationRecord
    belongs_to :user
    has_many :enrollments, dependent: :destroy
    has_many :lectures, dependent: :destroy
   has_many_attached :documents, dependent: :destroy

    #has_many :course_files, dependent: :destroy
    #accepts_nested_attributes_for :course_files, allow_destroy: true
  # validate :check_file_type

  private

  # def check_file_type
  #   if documents.attached? && !documents.content_type.in?(%i(application/pdf))
  #     documents.purge # delete the uploaded file
  #     errors.add(:documents, 'Must be a PDF or a DOC file')
  #   end
  # end

end
