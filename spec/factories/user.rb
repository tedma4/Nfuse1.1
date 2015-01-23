FactoryGirl.define do
  factory :user do
    first_name 'Test User'
    last_name 'Nfuse'
    email 'test_user@nfuse.com'
    password 'password'
    password_confirmation 'password'
  end
end
