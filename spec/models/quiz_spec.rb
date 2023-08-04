

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  let(:lecture) { create(:lecture) }

  describe 'associations' do
    it { should belong_to(:lecture) }
    it { should have_many(:questions).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title).with_message("Title cant be blank ...") }
    it { should validate_length_of(:title).is_at_most(100) }
  end

end
