class Lecture < ApplicationRecord
    belongs_to :course
    belongs_to :user
    validates :video, presence: { message: 'must be attached' }
    has_one_attached :video
    has_one :quiz, dependent: :destroy
    accepts_nested_attributes_for :quiz
    #validate :validate_video_format

    def validate_video_format
    return unless video.attached?

    unless video.content_type.in?(%w[video/mp4 video/mov video/avi])
      errors.add(:video, 'must be in MP4, MOV, or AVI format')
    end
  end
end


