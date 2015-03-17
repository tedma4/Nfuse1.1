FactoryGirl.define do
  factory :shout do
   # belongs to a User
   association :user, factory: :user
   content 'This is content for the shout - the text string.'
  end
end
