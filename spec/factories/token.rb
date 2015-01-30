require 'securerandom'

FactoryGirl.define do
  factory :token do
    provider  {['twitter', 'instagram', 'facebook', 'youtube', 'identity'].map(&:to_s).sample}
    uid  {rand(2000)}
    access_token {SecureRandom.hex(10)}
    user_id {create(:user).id}
    access_token_secret {SecureRandom.hex(20)}
  end
end