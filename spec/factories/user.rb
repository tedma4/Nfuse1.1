FactoryGirl.define do
  email = proc do 
    Faker::Internet.email
  end
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "nfuse#{n}_#{email.call}"}
    password 'password'
    password_confirmation 'password'
  end
end
