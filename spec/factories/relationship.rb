FactoryGirl.define do
  email = proc do 
    Faker::Internet.email
  end
  factory :relationship do
    followed { create(:user) }
    follower { create(:user) }
  end
end
