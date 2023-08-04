require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:quiz) { create(:quiz) }

  describe 'associations' do
    it { should belong_to(:quiz) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end
