module Networks
  class Timeline
  include ApplicationHelper
    attr_accessor :params
    attr_reader :unauthed_accounts, :authed
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
      @authed = true
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
      fl = flickr_posts
      tb = tumblr_posts
      up = users_posts
      merge_posts = (tw + fb + ig + yt + gp + vp + fl + tb + up)#.sort_by{|t| - t.created_time.to_i}
    end
    private

  def users_posts
    users_posts = []
    if @user.shouts.any?
      users_posts = @user.shouts.first(25).map { |post| Nfuse::Post.new(post) }
    else
      users_posts
    end
    users_posts
  end

    def twitter_posts
      twitter_posts = []
      if user_has_provider?('twitter', @user)
        token = @user.tokens.find_by(provider: 'twitter')
        client = configure_twitter(token.access_token, token.access_token_secret)
        begin
          twitter_posts = client.user_timeline(count: 25).map { |post| Networks::Post.from(post, 'twitter', @user)}
        rescue => e
          @unauthed_accounts << "twitter"
        end
        twitter_posts
      else
        twitter_posts
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
      facebook_posts = []
      if user_has_provider?('facebook', @user)
        token = @user.tokens.find_by(provider: 'facebook')
        app_secret = ENV['facebook_app_secret']
        client = Koala::Facebook::API.new(token.access_token, app_secret)
        begin
          facebook_posts = client.get_connections('me', 'posts').first(25).map { |post| Networks::Post.from(post, 'facebook', @user) }
        rescue => e
          @unauthed_accounts << "facebook"
        end
        facebook_posts
      else
        facebook_posts
      end
    end

    def youtube_posts
      youtube_posts = []
      if user_has_provider?('google_oauth2', @user)
        token = @user.tokens.find_by(provider: 'google_oauth2')
        client = configure_youtube(token.access_token, token.refresh_token)
        begin
          youtube_posts = client.videos.first(15).map { |post| Networks::Post.from(post, 'youtube', @user) }
        rescue => e
          @unauthed_accounts << "youtube"
        end
        youtube_posts
      else
        youtube_posts
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
      gplus_posts = []
      if user_has_provider?('gplus', @user)
        token = @user.tokens.find_by(provider: 'gplus').uid
        client = configure_gplus(token)
        begin
          gplus_posts = client.list_activities.items.map { |post| Networks::Post.from(post, 'gplus', @user) }
        rescue => e
          @unauthed_accounts << 'gplus'
        end
        gplus_posts
      else
        gplus_posts
      end
    end

    def configure_gplus(uid)
      GooglePlus.api_key = ENV['youtube_dev_key']
      # GooglePlus.access_token = access_token
      GooglePlus::Person.get(uid)
    end

    def vimeo_posts
      vimeo_posts = []
      if user_has_provider?('vimeo', @user)
        token = @user.tokens.find_by(provider: 'vimeo')
        client = Vmo::Request.get_user(token.access_token)
        begin
          vimeo_posts = client.videos.take(15).map { |post| Networks::Post.from(post, 'vimeo', @user) }
        rescue => e
          @unauthed_accounts << "vimeo"
        end
        vimeo_posts
      else
        vimeo_posts
      end
    end

    def tumblr_posts
      tumblr_posts = []
      if user_has_provider?('tumblr', @user)
        token = @user.tokens.find_by(provider: 'tumblr')
        client = configure_tumblr(token.access_token, token.access_token_secret)
        username = client.info['user']['name']
        begin
          tumblr_posts = client.posts("#{username}.tumblr.com")['posts'].map { |post| Networks::Post.from(post, 'tumblr', @user)}
        rescue => e
          @unauthed_accounts << "tumblr"
        end
        tumblr_posts
      else
        tumblr_posts
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
      flickr_posts = []
      if user_has_provider?('flickr', @user)
        token = @user.tokens.find_by(provider: 'flickr')
        client = configure_flickr(token.access_token, token.access_token_secret)
        begin
          flickr_posts = client.people.getPhotos('user_id' => token.uid).map { |post| Networks::Post.from(post, 'flickr', @user) }
        rescue => e
          @unauthed_accounts << "flickr"
        end
        flickr_posts
      else
        flickr_posts
      end
    end
    
    def configure_flickr(access_token, access_token_secret)
      FlickRaw.api_key=ENV["flickr_key"]
      FlickRaw.shared_secret=ENV["flickr_secret"]
      client = FlickRaw::Flickr.new
      client.access_token = access_token
      client.access_secret = access_token_secret
      client
    end

    def instagram_posts
      if user_has_provider?('instagram', @user)
        token = @user.tokens.find_by(provider: 'instagram')
        client = Instagram::Api.new(token.access_token, nil)
        begin
          instagram_posts = client.get_timeline.posts.map { |post| Networks::Post.from(post,'instagram', @user) }
        rescue => e
          @unauthed_accounts << "instagram"
        end
        instagram_posts
      else
        []
      end
    end

    def auth_instagram(instagram_posts)
      unless instagram_posts.authed
        @unauthed_accounts << "instagram"
      end
    end
  end
end
