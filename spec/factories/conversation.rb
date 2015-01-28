FactoryGirl.define do

  factory :conversation do
    sender_id { create(:user).id }
    recipient_id { create(:user).id }
  end

end
