FactoryGirl.define do
  factory :shout do
   # belongs to a User
   association :user, factory: :user
   #content 'This is content for the shout - the text string.'
   factory :shout_with_picture do
     pic Rack::Test::UploadedFile.new("/#{Rails.root.to_s}/spec/factories/images/one.jpg", 'image/jpg')
   end
  end
end
