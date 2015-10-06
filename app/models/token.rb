class Token < ActiveRecord::Base

  validates :provider, presence: true
  validates :uid, presence: true
  belongs_to :user
  cattr_accessor :auth, :token
  # Still all Class methods
  class << self

    def by_name(name)
      where(provider: name)
    end
    # For extendabililty - down the road you might want 
    # * facebook token * youtube * next new social media *
    # * e.g.
    # update_or_create_token(id, auth, provider='twitter')
    # update_or_create_token(id, auth, provider='facebook')

    def update_or_create_token(id, auth, provider='basic')
      build_token(id, auth)
      self.send("#{provider}_token")
      save_and_return
    end

    def update_or_create_with_twitter_omniauth(id, auth)
      update_or_create_token(id, auth, 'twitter')
    end

    def update_or_create_with_vimeo_omniauth(id, auth)
      update_or_create_token(id, auth, 'vimeo')
    end

    def update_or_create_with_youtube_omniauth(id, auth)
      update_or_create_token(id, auth, 'google_oauth2')
    end

    def update_or_create_with_gplus_omniauth(id, auth)
      update_or_create_token(id, auth, 'gplus')
    end

    def update_or_create_with_flickr_omniauth(id, auth)
      update_or_create_token(id, auth, 'flickr')
    end

    def update_or_create_with_tumblr_omniauth(id, auth)
      update_or_create_token(id, auth, 'tumblr')
    end

    def update_or_create_with_other_omniauth(id, auth)
      # defaults to basic.
      update_or_create_token(id, auth)
    end

    # Utility Methods
    private 

    def build_token(id, auth)
      self.auth = auth
      @token = where(provider: auth["provider"], uid: auth["uid"]).first_or_initialize
      @token.provider = provider
      @token.uid      = auth_uid
      @token.user_id  = id
      self.token = @token
    end

    # A bit of over engineering.. I know....
    def extra_access_token
      auth["extra"]["access_token"]
    end

    def credentials_token
      auth["credentials"]["token"]
    end

    def credentials_secret
      auth["credentials"]["secret"]
    end

    def credentials_uid
      auth["uid"]
    end

    def provider
      auth['provider']
    end

    def auth_uid
      auth['uid']
    end

    def credentials_refresh
      auth['credentials']['refresh_token']
    end

    def credentials_expires
      DateTime.now + auth['credentials']["expires_in"].to_i.seconds      
    end

    # Social Media Specific

    def twitter_token
      @token.access_token        = extra_access_token.token
      @token.access_token_secret = extra_access_token.secret
    end

    def basic_token
      @token.access_token        = credentials_token
    end

    def google_oauth2_token
      @token.access_token        = credentials_token
      @token.refresh_token       = credentials_refresh
      #@token.expiresat           = credentials_expires
    end

    def gplus_token
      @token.access_token        = credentials_token
      # @token.refresh_token       = credentials_refresh
      #@token.expiresat           = credentials_expires
    end

    def vimeo_token
      @token.access_token        = credentials_token
      @token.access_token_secret = credentials_secret
      # @token.uid                 = credentials_uid
    end

    def flickr_token
      @token.access_token        = extra_access_token.token
      @token.access_token_secret = extra_access_token.secret
    end

    def tumblr_token
      @token.access_token        = extra_access_token.token
      @token.access_token_secret = extra_access_token.secret
    end

    # def facebook_token; end
    # def instagram_token; end

    def save_and_return
      @token.save!
      @token
    end
  end

  def configure_twitter(access_token, access_token_secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_api_key"]
      config.consumer_secret     = ENV["twitter_api_secret"]
      config.access_token        = access_token
      config.access_token_secret = access_token_secret
    end
    client
  end

  def configure_tumblr(access_token, access_token_secret)
    Tumblr.configure do |config|
      config.consumer_key        = ENV['tumblr_consumer_key']
      config.consumer_secret     = ENV['tumblr_consumer_secret']
      config.oauth_token         = access_token
      config.oauth_token_secret  = access_token_secret
    end
    client = Tumblr::Client.new#(client: :httpclient)
  end
  
  def configure_vimeo(access_token, access_token_secret)
    cfg = Vmo::Base.new(access_token)
  end

  def configure_youtube(access_token, refresh_token)#, expiresat)
    Yt.configure do |config|
      config.client_id = ENV["google_client_id"]
      config.client_secret = ENV["google_client_secret"]
    end
    client = Yt::Account.new access_token: access_token, refresh_token: refresh_token
    client
  end

  def configure_gplus(uid, access_token)
    GooglePlus.api_key = ENV['youtube_dev_key']
    # gplus_access = @user.tokens.find_by_provider('gplus')
    client = GooglePlus::Person.get(uid)
    post = GooglePlus::Activity.get(post_id)
  end

  def configure_flickr(access_token, access_secret)
    FlickRaw.api_key=ENV["flickr_key"]
    FlickRaw.shared_secret=ENV["flickr_secret"]
    # FlickRaw.secure = false

    client = FlickRaw::Flickr.new
    client.access_token = access_token
    client.access_secret = access_secret
    client
  end

  def configure_facebook(access_token)
    app_secret = ENV['facebook_app_secret']
    # oauth = Koala::Facebook::OAuth.new(app_id, app_secret, callback_url)

    client = Koala::Facebook::API.new(access_token, app_secret)
  end
end