FactoryGirl.define do
  email = proc do 
    Faker::Internet.email
  end
  factory :user do
    user_name  { Faker::Internet.user_name( (10..15) ) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number.gsub(' ', '-') }
    intro { '4081' }

    sequence(:email) { |n| "#{email.call}"}
    password 'password'
    password_confirmation 'password'
  end
end
