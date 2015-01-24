FactoryGirl.define do
  factory :user do
    first_name 'Test User'
    last_name 'Nfuse'
    sequence(:email) { |n| "test_user_#{n}@nfuse.com"}
    password 'password'
    password_confirmation 'password'
  end
end
