

require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:name) }
  end

  describe 'scopes' do
    it 'returns public rooms' do
      public_room = create(:room, is_private: false)
      private_room = create(:room, is_private: true)

      expect(Room.public_rooms).to eq([public_room])
    end
  end

  describe 'associations' do
    it { should have_many(:messages) }
  end

  describe 'callbacks' do
    it 'broadcasts a room after create' do
      room = build(:room)
      expect_any_instance_of(Room).to receive(:broadcast_append_to).with('rooms')

      room.save
    end
  end
end
