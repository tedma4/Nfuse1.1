FactoryGirl.define do

  factory :shout do
    # belongs to a User
    association :user, factory: :user

    factory :shout_with_picture do
      pic File.new("/#{Rails.root.to_s}/spec/factories/images/one.jpg")
    end
    # factory :video
  end
end
