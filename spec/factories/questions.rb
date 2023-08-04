FactoryBot.define do
  factory :question do
    sequence(:content) { |n| "Question #{n} content" }
    association :quiz
  end
end
