require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  let(:user) { create(:user) }
  let(:course) { create(:course) }

  describe "validations" do
    subject { build(:enrollment, user: user, course: course) }

    it { should validate_uniqueness_of(:user_id).scoped_to(:course_id).with_message("has already enrolled in this course") }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end

end
