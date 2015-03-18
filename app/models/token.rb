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

    def credentantials_token
      auth["credentials"]["token"]
    end

    def provider
      auth['provider']
    end

    def auth_uid
      auth['uid']
    end

    def refresh
      auth['credentials']['refresh_token']
    end

    def expires
      DateTime.now + auth['credentials']["expires_in"].to_i.seconds      
    end

    # Social Media Specific

    def twitter_token
      @token.access_token        = extra_access_token.token
      @token.access_token_secret = extra_access_token.secret
    end

    def basic_token
      @token.access_token       = credentantials_token
    end

    def google_oauth2_token
      @token.access_token   = credentantials_token
      @token.refresh_token  = refresh
      @token.expiresat      = expires
    end

    def vimeo_token
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
  	  config.consumer_key = 'n6107y4oqyomedLDZsMUytEoO'
  	  config.consumer_secret = 'jTndXRNGkw6eTI77TJixAxiCuD5D9eKE10GjrzL4WIDwaMquU9'
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
    client
  end

  def configure_vimeo(access_token, access_token_secret)
    video = Vimeo::Advanced::Video.new do |config|
      config.consumer_key = '3a0aa8929985db9ab9e13b8af905fb557c88a3bf'
      config.consumer_secret = '1d803443422e5eeb806756fd49eb2831240ff387'
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
    video
  end

  def configure_youtube(access_token, refresh_token)
    client = YouTubeIt::OAuth2Client.new do |config|
      config.client_access_token = access_token 
      config.client_refresh_token = refresh_token
      config.client_id = "585499897487-s0rj3prs5c56ui8vjqnr0l8e66fmco59.apps.googleusercontent.com"
      config.client_secret = "yQjPXajecmamPWswzrEtAkaA"
      config.dev_key = "AIzaSyDURKK2l5VPmwaj3b3DtXaNg9HDB79syrI"
      #config.expires_at = "expiration time"
    end
    client
  end
end
