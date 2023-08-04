FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    is_private { false }
  end
end
