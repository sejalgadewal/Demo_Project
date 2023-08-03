require 'rails_helper'

RSpec.describe Course, type: :model do
  
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:lectures).dependent(:destroy) }
  end
  
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(100) }
    it { should validate_presence_of(:documents) }
  end
  
  describe 'scopes' do
    describe '.enrolled_by_student' do
      let(:student) { create(:user) }
      let(:course1) { create(:course, user: student) }
      let(:course2) { create(:course, user: student) }
      let!(:enrollment1) { create(:enrollment, user: student, course: course1) }
  
      it 'returns courses enrolled by a specific student' do
        enrolled_courses = Course.enrolled_by_student(student.id)
        expect(enrolled_courses).to include(course1)
        expect(enrolled_courses).not_to include(course2)
      end
    end
  end
  
end




# spec/models/course_spec.rb
