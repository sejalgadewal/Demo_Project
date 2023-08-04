require 'rails_helper'

RSpec.describe Lecture, type: :model do
  describe "associations" do
    it "belongs to a course" do
      association = described_class.reflect_on_association(:course)
      expect(association.macro).to eq :belongs_to
    end
    
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
    
    it "has one attached video" do
      association = described_class.reflect_on_association(:video_attachment)
      expect(association).not_to be_nil
    end
    
    it "has one quiz that is dependent on destroy" do
      association = described_class.reflect_on_association(:quiz)
      expect(association.macro).to eq :has_one
      expect(association.options[:dependent]).to eq :destroy
    end
  end

  describe "validations" do
    it "validates presence of video with custom message" do
      lecture = Lecture.new
      lecture.valid?
      expect(lecture.errors[:video]).to include('must be attached')
    end
    
  end

end
