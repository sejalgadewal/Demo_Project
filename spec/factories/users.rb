FactoryBot.define do
    factory :user do
       name { "John Doe" }
       username {"johnd"}
       #email { "john@example.com" }
       password {"password"}
       email { Faker::Internet.unique.email }
   
    end
  end
  