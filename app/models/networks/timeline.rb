module Networks
  class Timeline
  include ApplicationHelper
    attr_accessor :params
    attr_reader :unauthed_accounts
              # :twitter_pagination_id,
              # :facebook_pagination_id,
              # :instagram_max_id,
              # :youtube_pagination_id,
              # :gplus_pagination_id,
              # :vimeo_pagination_id,
              # :flickr_pagination_id,
              # :tumblr_pagination_id,
              # :nfuse_pagination_id

    def initialize(user=current_user)
      @user = user
      @unauthed_accounts = []
    end

    # I could set all the providers in the initializer like the pages do
    # but I need to make it so that the correct info gets passed

    def construct(params)
      self.params = params
      tw = twitter_posts
      fb = facebook_posts
      ig = instagram_posts
      yt = youtube_posts
      gp = gplus_posts
      vp = vimeo_posts
      up = users_posts
      fl = flickr_posts
      tb = tumblr_posts
      HubConcatenator.new.merge(tw, ig, up, vp, yt, fl, gp, tb, fb )
    end

  # user_provider_info = current_user.tokens.pluck(:provider, :uid, :access_token, :access_token_secret)
  # get_provider = Hash[[:provider, :uid, :access_token, :access_token_secret].zip(user_provider_info.transpose)]
  # {
  #  :provider=>["facebook", "tumblr", "twitter", "google_oauth2", "vimeo"], 
  #  :uid=>["1187467057945665", "tedma4", "2525729819", "108818010640714676811", "36828893"], 
  #  :access_token=>["CAAHRjuMYUXIBAFHuZAaH0qMNPdw3bVCcUabucr5Lw0OmjI0qcLDuFaChUaJ1fUE2lBumQmCEJ4iT1hsxyHZCNe8RhdLiuRZBNFiDFf16WodK8dTG2k1xmXbsgZCKXeSzmtnjD8ZCbMTn4ogARTmIpXG9ZCZBAZAOHLGZBXPfwvPnXLvi3pIMuo02Cog8RWNplMUFJUJhttYTh6gZDZD", "usYpVEY46coleHLHU5mw61Hz4aUf0ryhPpv2QN3XjpeOnUw4sg", "2525729819-eQhtgxvzDap1ZBdLkAs24twWwTZu0i4mUMj3rcz", "ya29.GwLrdvBitqt9CqPdayjPI50thdfmNv--1oK8O_bjocqo3QwYp0Y3thATu0et48CcBclA", "2b40dcd0aca1551d8cd82bb7f9480c21"], 
  #  :acces_token_secret=>[nil, "9I6S7flKXsDXcr4QrKUhU5pTWAy7nt6zGzM3514NgFQjM4qrL6", "yOsbHmfEgAb91o4HfQ6oL0l17ratMkMqeGnmPA5WdVo87", nil, nil]
  # }
  # I need to make the construct params based only on the providers the user has
  # to reduce the number of times it checks to see if a user has one of these 
  # networks already

  # def get_providers(provider, uid, access_token, access_token_secret)
  #   provider_and_token = {}
  #   @user.tokens.pluck(:provider)
  
  # end

    def twitter_posts
      token = @user.tokens.find_by(provider: 'twitter')
      client = configure_twitter(token.access_token, token.access_token_secret)
      begin
        posts = client.user_timeline(count: 25)
        posts.map { |post| Networks::Post.from(post, 'twitter')}
      rescue => e
        @unauthed_accounts << "twitter"
      end
    end

    def configure_twitter(access_token, access_token_secret)
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["twitter_api_key"]
        config.consumer_secret     = ENV["twitter_api_secret"]
        config.access_token        = access_token
        config.access_token_secret = access_token_secret
      end
    end

    def facebook_posts
      token = @user.tokens.find_by(provider: 'facebook').access_token
      app_secret = ENV['facebook_app_secret']
      client = Koala::Facebook::API.new(token, app_secret)
      begin
        posts = client.get_connections('me', 'posts').first(25)
        posts.map { |post| Networks::Post.from(post, 'facebook') }
      rescue => e
        @unauthed_accounts << "facebook"
      end
    end

    def youtube_posts
      token = @user.tokens.find_by(provider: 'google_oauth2')
      client = configure_youtube(token.access_token, token.refresh_token)
      begin
        posts = client.videos.first(15)
        posts.map { |post| Networks::Post.from(post, 'youtube') }
      rescue => e
        @unauthed_accounts << "youtube"
      end
    end

    def configure_youtube(access_token, refresh_token)#, expiresat)
      Yt.configure do |config|
        config.client_id = ENV["google_client_id"]
        config.client_secret = ENV["google_client_secret"]
      end
      client = Yt::Account.new(access_token: access_token, refresh_token: refresh_token)
      client
    end

    def gplus_posts
      token = @user.tokens.find_by(provider: 'gplus')
      client = configure_gplus(token.uid.to_s, token.access_token)
      begin
        posts = client.list_activities.items
        posts.map { |post| Networks::Post.from(post, 'gplus') }
      rescue => e
        @unauthed_accounts << "gplus"
      end
    end

    def configure_gplus(uid, access_token)
      GooglePlus.api_key = ENV['youtube_dev_key']
      # gplus_access = @user.tokens.find_by_provider('gplus')
      client = GooglePlus::Person.get(uid)
    end

    def vimeo_posts
      token = @user.tokens.find_by(provider: 'vimeo')
      client = Vmo::Request.get_user(token.access_token)
      begin
        posts = client.videos.take(15)
        posts.map { |post| Networks::Post.from(post, 'vimeo') }
      rescue => e
        @unauthed_accounts << "vimeo"
      end
    end

    def tumblr_posts
      token = @user.tokens.find_by(provider: 'tumblr')
      client = configure_tumblr(token.access_token, token.access_token_secret)
      username = client.info['user']['name']
      begin
        posts = client.posts("#{username}.tumblr.com")['posts']
        posts.map { |post| Networks::Post.from(post, 'tumblr')}
      rescue => e
        @unauthed_accounts << "tumblr"
      end
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

    def flickr_posts
      token = @user.tokens.find_by(provider: 'flickr').access_token
      client = configure_flickr(token.access_token, token.access_token_secret)
      begin
        posts = client.people.getPhotos('user_id' => token.uid)
        posts.map { |post| Networks::Post.from(post, 'flickr') }
      rescue => e
        @unauthed_accounts << "flickr"
      end
    end
    
    def configure_flickr(access_token, access_secret)
      FlickRaw.api_key=ENV["flickr_key"]
      FlickRaw.shared_secret=ENV["flickr_secret"]
      client = FlickRaw::Flickr.new
      client.access_token = access_token
      client.access_secret = access_secret
      client
    end

    def instagram_posts
      token = @user.tokens.find_by(provider: 'instagram')
      client = Instagram::Api.new(token.access_token, nil)
      begin
        posts = client.get_timeline
        posts.map { |post| Networks::Post.from(post, @user) }
      rescue => e
        auth_instagram(instagram_timeline)
      end
    end

    def auth_instagram(instagram_posts)
      unless instagram_posts.authed
        @unauthed_accounts << "instagram"
      end
    end

  end
end


class HubConcatenator
  def self.merge(twitter_posts)
    (twitter_posts).sort_by { |post| post.created_time }.reverse
  end
end
