module Networks
  class Timeline
    attr_accessor :params
    attr_reader :unauthed_accounts

    def initialize(user=current_user)
      @user = user
      @unauthed_accounts = []
    end

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

    def twitter_posts
      token = @user.tokens.find_by(provider: 'twitter')
      client = configure_twitter(token.access_token, token.access_token_secret)
      begin
        post = client.user_timeline(count: 25).attrs
        Networks::Post.from(post, 'twitter')
      rescue => e
        @unauthed_accounts << "twitter"
      end
    end

    def facebook_posts
      token = @user.tokens.find_by(provider: 'facebook').access_token
      app_secret = ENV['facebook_app_secret']
      client = Koala::Facebook::API.new(token, app_secret)
      begin
        entry = client.get_connections('me', 'posts').first(25)
        Networks::Post.from(post, 'facebook')
      rescue => e
        @unauthed_accounts << "facebook"
      end
    end

    def youtube_posts
      token = @user.tokens.find_by(provider: 'google_oauth2')
      client = configure_youtube(token.access_token, token.refresh_token)
      begin
        post = client.videos.first(15)
        Networks::Post.from(post, 'youtube')
      rescue => e
        @unauthed_accounts << "youtube"
      end
    end

    def gplus_posts
      token = @user.tokens.find_by(provider: 'gplus')
      client = configure_gplus(token.uid.to_s, token.access_token)
      begin
        post = client.list_activities.items
        Networks::Post.from(post, 'gplus')
      rescue => e
        @unauthed_accounts << "gplus"
      end
    end

    def vimeo_posts
      token = @user.tokens.find_by(provider: 'vimeo').access_token
      client = Vmo::Request.get_user(token.access_token)
      begin
        post = client.videos.take(15)
        Networks::Post.from(post, 'vimeo')
      rescue => e
        @unauthed_accounts << "vimeo"
      end
    end

    def tumblr_posts
      token = @user.tokens.find_by(provider: 'tumblr')
      client = configure_tumblr(token.access_token, token.access_token_secret)
      username = client.info['user']['name']
      begin
        post = client.posts("#{username}.tumblr.com")['posts']
        Networks::Post.from(post, 'tumblr')
      rescue => e
        @unauthed_accounts << "tumblr"
      end
    end

    def flickr_posts
      token = @user.tokens.find_by(provider: 'flickr').access_token
      client = configure_flickr(token.access_token, token.access_token_secret)
      begin
        post = client.people.getPhotos('user_id' => token.uid)
        Networks::Post.from(post, 'flickr')
      rescue => e
        @unauthed_accounts << "flickr"
      end
    end

    def instagram_posts
      token = @user.tokens.find_by(provider: 'instagram')
      client = Instagram::Api.new(token.access_token, nil)
      begin
        instagram_posts = client.posts.map { |post| Networks::Post.from(post, @user) }
      rescue => e
        auth_instagram(instagram_timeline)
      end
    end

    def auth_instagram(instagram_posts)
      unless instagram_posts.authed
        @unauthed_accounts << "instagram"
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

    def configure_youtube(access_token, refresh_token)#, expiresat)
      Yt.configure do |config|
        config.client_id = ENV["google_client_id"]
        config.client_secret = ENV["google_client_secret"]
      end
      client = Yt::Account.new(access_token: access_token, refresh_token: refresh_token)
      client
    end

    def configure_gplus(uid, access_token)
      GooglePlus.api_key = ENV['youtube_dev_key']
      # gplus_access = @user.tokens.find_by_provider('gplus')
      client = GooglePlus::Person.get(uid)
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

    def configure_flickr(access_token, access_secret)
      FlickRaw.api_key=ENV["flickr_key"]
      FlickRaw.shared_secret=ENV["flickr_secret"]
      client = FlickRaw::Flickr.new
      client.access_token = access_token
      client.access_secret = access_secret
      client
    end

  end
end


class HubConcatenator
  def self.merge(twitter_posts)
    (twitter_posts).sort_by { |post| post.created_time }.reverse
  end
end
