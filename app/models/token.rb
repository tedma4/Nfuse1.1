class Token < ActiveRecord::Base

  validates :provider, presence: true
  validates :uid, presence: true

  belongs_to :user

  def self.by_name(name)
    where(provider: name)
  end

  def self.update_or_create_with_twitter_omniauth(id, auth)
    token = where(provider: auth["provider"], uid: auth["uid"]).first_or_initialize
    token.provider = auth["provider"]
    token.uid = auth["uid"]
    token.access_token = auth["extra"]["access_token"].token
    token.access_token_secret = auth["extra"]["access_token"].secret
    token.user_id = id
    token.save!
    token
  end

  def self.update_or_create_with_omniauth(id, auth)
    token = where(provider: auth["provider"], uid: auth['uid']).first_or_initialize
    token.provider = auth["provider"]
    token.uid = auth["uid"]
    token.access_token = auth["credentials"]["token"]
    token.user_id = id
    token.save!
    token
  end

  def configure_twitter(access_token, access_token_secret)
    client = Twitter::REST::Client.new do |config|
  	  config.consumer_key = 'n6107y4oqyomedLDZsMUytEoO'
  	  config.consumer_secret = 'jTndXRNGkw6eTI77TJixAxiCuD5D9eKE10GjrzL4WIDwaMquU9'
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
    client
  end

end
