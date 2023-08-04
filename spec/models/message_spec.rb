

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }
  let(:room) { create(:room) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe 'callbacks' do
    it 'broadcasts a message after create' do
      message = build(:message, user: user, room: room)
      expect_any_instance_of(Message).to receive(:broadcast_append_to).with(message.room)

      message.save
    end
  end
end
