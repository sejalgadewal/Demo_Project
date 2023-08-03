FactoryBot.define do
  factory :course do
    title { 'Sample Title' }
    description { 'Sample Description' }
    user
  end
end


