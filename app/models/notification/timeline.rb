module Notification
  class Timeline
    attr_accessor :params

    def initialize(post_id, provider, user=current_user)
      @post_id = post_id
      @user = user
      @provider = provider
    end

    def construct(params)
      self.params = params
      sp = single_post(@post_id)
      NotificationConcatenator.new.merge(sp)
    end

    def single_post(post_id)
      case(@provider)
        when 'twitter'
          token = @user.tokens.find_by(provider: 'twitter')
          client = configure_twitter(token.access_token, token.access_token_secret)
          client.status(post_id).attrs.map { |entry| Notification::Entry.from(entry, 'twitter') }
        when 'facebook'
          fb_post = []
          access_token = @user.tokens.find_by(provider: 'facebook').access_token
          app_secret = ENV['facebook_app_secret']
          client = Koala::Facebook::API.new(access_token, app_secret)
          fb_post = client.get_object(post_id).map { |entry| Notification::Entry.from(entry, 'facebook') }
          fb_post
        when 'youtube'
          token = @user.tokens.find_by(provider: 'google_oauth2')
          client = configure_youtube(token.access_token, token.refresh_token)
          video = Yt::Video.new id: post_id, auth: client
          video.title #Leave this here. Youtube is weird. the first time the video is called you get an error but not the second time. WTF???
          video.snippet.data.map {|entry| Notification::Entry.from(entry, 'youtube') }
        when 'gplus'
          uid = @user.tokens.find_by(provider: 'gplus').uid
          configure_gplus(uid)
          post.map { |entry| Notification::Entry.from(entry, 'gplus') }
        when 'vimeo'
          access_token = @user.tokens.find_by(provider: 'vimeo').access_token
          user = configure_vimeo(access_token)
          user.videos.find(id: post_id).map { |entry| Notification::Entry.from(entry, 'vimeo') }
        when 'tumblr'
          token = @user.tokens.find_by(provider: 'tumblr')
          client = configure_tumblr(token.access_token, token.access_token_secret)
          username = client.info['user']['name']
          client.posts("#{username}.tumblr.com", id: post_id).map { |entry| Notification::Entry.from(entry, 'tumblr') }
        when 'flickr'
          token = @user.tokens.find_by(provider: 'flickr').access_token
          client = configure_flickr(token.access_token, token.access_token_secret)
          info = client.photos.getInfo(:photo_id => post_id)
          FlickRaw.url_z(info).map {|entry| Notification::Entry.from(entry, 'flickr') }
        when 'instagram'
          token = @user.tokens.find_by(provider: 'instagram')
          instagram_api = Instagram::Api.new(token.access_token, nil)
          instagram_api.get_post(post_id).map { |entry| Notification::Entry.from(entry, 'instagram') }
      end
    end

      # def configure_facebook(access_token)
      #   app_secret = ENV['facebook_app_secret']
      #   client = Koala::Facebook::API.new(access_token, app_secret)
      # end

      def configure_twitter(access_token, access_token_secret)
        Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["twitter_api_key"]
          config.consumer_secret     = ENV["twitter_api_secret"]
          config.access_token        = access_token
          config.access_token_secret = access_token_secret
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
      
      def configure_vimeo(access_token)
        client = Vmo::Base.new(access_token)
          user = Vmo::Request.get_user(access_token)
      end

      # def configure_vimeo(access_token)
      #   consumer_secret = ENV['vimeo_client_secret']
      #   consumer_key = ENV['vimeo_client_id']
      #   client = Vmo::Advanced::Base.new(access_token)
      #     user = Vmo::Advanced::Video(consumer_secret, consumer_key, access_token )
      # end

      def configure_youtube(access_token, refresh_token)#, expiresat)
        Yt.configure do |config|
          config.client_id = ENV["google_client_id"]
          config.client_secret = ENV["google_client_secret"]
        end
        client = Yt::Account.new(access_token: access_token, refresh_token: refresh_token)
        client
      end

      def configure_gplus(uid)
        GooglePlus.api_key = ENV['youtube_dev_key']
        client = GooglePlus::Person.get(uid)
        post = GooglePlus::Activity.get(post_id)
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

class NotificationConcatenator
  def merge(single_post)
    (single_post)
  end
end