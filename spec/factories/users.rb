FactoryBot.define do
    factory :user do
       name { "John Doe" }
       username {"johnd"}
       email { "john@example.com" }
       password {"password"}
    end
  end
  