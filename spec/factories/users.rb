FactoryBot.define do
    factory :user do
        email { FFaker::Internet.email }
        name { "John Doe" }
        username {"johnd"}
        #email { "john@example.com" }
        password {"password"}
      
    end
  end
  