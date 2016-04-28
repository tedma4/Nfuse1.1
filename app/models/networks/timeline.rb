module Networks
  class Timeline
  include ApplicationHelper
#     require 'thread'
    attr_accessor :params
    attr_reader :unauthed_accounts, :authed
              # :twitter_pagination_id,
              # :facebook_pagination_id,
              # :instagram_max_id,
              # :youtube_pagination_id,
              # :gplus_pagination_id,
              # :vimeo_pagination_id,
              # :tumblr_pagination_id,
              # :nfuse_pagination_id

    def initialize(user=current_user)
      @user = user
      #@token = token
      @unauthed_accounts = []
      @authed = true
    end    

    def construct(params)
      self.params = params
      # tw = twitter_posts
      # fb = facebook_posts
      # ig = instagram_posts
      # yt = youtube_posts
      # gp = gplus_posts
      # vp = vimeo_posts
      # tb = tumblr_posts
      # up = users_posts
      # merge_posts = (tw + fb + ig + yt + gp + vp + tb + up)#.sort_by{|t| - t.created_time.to_i}
      build_it
    end

    def build_it
      threads = []
      #Checking for just tokens isn't good because it ignores nfuse posts
      @token = @user.tokens.pluck(:provider, :uid, :access_token, :access_token_secret, :refresh_token)
        # hydra = Typhoeus::Hydra.hydra
      @token.each do |this|
        threads << Thread.new { instance_variable_set("@#{this.first}", self.send("#{this.first}_posts", *this)) }
        # request = Typhoeus::Request.new(instance_variable_set("@#{this.first}", self.send("#{this.first}_posts", *this)))
        # hydra.queue(request)
      end
      # hydra.run
      posts = threads.each(&:join)
      merge = []
      if @token.any? || @user.shouts.any?
        begin
          @token.each do |provider|
            if @unauthed_accounts.include?(provider.first)
              #Leavin this blank for now
            else
              if provider.first == 'twitter'
                @twitter = @twitter.delete_if { |twitter_post| twitter_post.attrs.has_key?(:retweeted_status) || twitter_post.attrs[:in_reply_to_status_id] != nil }
                merge << instance_variable_get("@#{provider.first}").map { |post| Networks::Post.from(post, "#{provider.first}", @user) }
              elsif provider.first == 'facebook'
                @facebook = @facebook.delete_if { |facebook_post| facebook_post['story'] ? (facebook_post['story'].include?('profile picture') || facebook_post['story'].include?('cover photo') ) : false }
                merge << @facebook.map { |post| Networks::Post.from(post, "#{provider.first}", @user) }
              # elsif provider.first == 'gplus'
              #   @gplus = @gplus.delete_if { |gplus_post| gplus_post['story'] ? (gplus_post['story'].include?('profile picture') || gplus_post['story'].include?('cover photo') ) : false }
              #   merge << @gplus.map { |post| Networks::Post.from(post, "#{provider.first}", @user) }
              elsif provider.first == 'tumblr'
                @tumblr = @tumblr.delete_if { |tumblr_post| ['chat', 'audio'].include?(tumblr_post['type'])}
                merge << @tumblr.map { |post| Networks::Post.from(post, "#{provider.first}", @user) }
              else
                merge << instance_variable_get("@#{provider.first}").map { |post| Networks::Post.from(post, "#{provider.first}", @user)}
              end
            end
          end
          if @user.shouts.any?
            users_posts = users_posts.reject { |nfuse_post| nfuse_post.exclusive == true}
            (merge.inject(:+)) + users_posts
          elsif merge.empty?
            users_posts = users_posts.reject { |nfuse_post| nfuse_post.exclusive == true}
            users_posts
          else
            merge.inject(:+)
          end
        rescue
          if @user.shouts.any?
            users_posts
          else
          merge
          end
        end
      else
        merge
      end
    end

    def users_posts
      @user.shouts.first(25).map { |post| Nfuse::Post.new(post) }
    end

    def twitter_posts(*this)
      #twitter_posts = []
      #if user_has_provider?('twitter', @user)
      #  token = @user.tokens.find_by(provider: 'twitter')
        client = configure_twitter(this[2], this[3])
        begin
          client.user_timeline(count: 25)#.map { |post| Networks::Post.from(post, 'twitter', @user)}
        rescue => e
          @unauthed_accounts << "twitter"
        end
     #   twitter_posts
     # else
     #   twitter_posts
     # end
    end

    def configure_twitter(access_token, access_token_secret)
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["twitter_api_key"]
        config.consumer_secret     = ENV["twitter_api_secret"]
        config.access_token        = access_token
        config.access_token_secret = access_token_secret
      end
    end

    def facebook_posts(*this)
      #facebook_posts = []
      #if user_has_provider?('facebook', @user)
      #  token = @user.tokens.find_by(provider: 'facebook')
        app_secret = ENV['facebook_app_secret']
        client = Koala::Facebook::API.new(this[2], app_secret)
        begin
          client.get_connections('me', 'posts').first(25)#.map { |post| Networks::Post.from(post, 'facebook', @user) }
        rescue => e
          @unauthed_accounts << "facebook"
        end
      #  facebook_posts
      #else
      #  facebook_posts
      #end
    end

    def google_oauth2_posts(*this)
      #youtube_posts = []
      #if user_has_provider?('google_oauth2', @user)
      #  token = @user.tokens.find_by(provider: 'google_oauth2')
        client = configure_youtube(this[2], this[4])
        begin
          client.videos.first(15)#.map { |post| Networks::Post.from(post, 'youtube', @user) }
        rescue => e
          @unauthed_accounts << "youtube"
        end
      #  youtube_posts
      #else
      #  youtube_posts
      #end
    end

    def configure_youtube(access_token, refresh_token)#, expiresat)
      Yt.configure do |config|
        config.client_id = ENV["google_client_id"]
        config.client_secret = ENV["google_client_secret"]
      end
      client = Yt::Account.new(access_token: access_token, refresh_token: refresh_token)
      client
    end

    def gplus_posts(*this)
      #url = []
      #if user_has_provider?('gplus', @user)
        #token = @user.tokens.find_by(provider: 'gplus').uid
        client = configure_gplus(this[1])
        begin
          client.list_activities.items#.map { |post| Networks::Post.from(post, 'gplus', @user) }
        rescue => e
          @unauthed_accounts << 'gplus'
        end
        # url
      #else
        #url
      #end
    end

    def configure_gplus(uid)
      GooglePlus.api_key = ENV['youtube_dev_key']
      # GooglePlus.access_token = access_token
      GooglePlus::Person.get(uid)
    end

    def vimeo_posts(*this)
      #vimeo_posts = []
      #if user_has_provider?('vimeo', @user)
      #  token = @user.tokens.find_by(provider: 'vimeo')
        client = Vmo::Request.get_user(this[2])
        begin
          client.videos.take(15)#.map { |post| Networks::Post.from(post, 'vimeo', @user) }
        rescue => e
          @unauthed_accounts << "vimeo"
        end
      #  vimeo_posts
      #else
      #  vimeo_posts
      #end
    end

    def tumblr_posts(*this)
      #tumblr_posts = []
      #if user_has_provider?('tumblr', @user)
      #  token = @user.tokens.find_by(provider: 'tumblr')
        client = configure_tumblr(this[2], this[3])
        username = client.info['user']['name']
        begin
          client.posts("#{username}.tumblr.com")['posts']#.map { |post| Networks::Post.from(post, 'tumblr', @user)}
        rescue => e
          @unauthed_accounts << "tumblr"
        end
      #  tumblr_posts
      #else
      #  tumblr_posts
      #end
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

    def instagram_posts(*this)
      #url = []
      #if user_has_provider?('instagram', @user)
        #token = @user.tokens.find_by(provider: 'instagram')
        client = Instagram::Api.new(this[2], nil)
        begin
          client.get_timeline.posts#.map { |post| Networks::Post.from(post,'instagram', @user) }
        rescue => e
          @unauthed_accounts << "instagram"
        end
        #url
      #else
      #url
      #end
    end

    def auth_instagram(instagram_posts)
      unless instagram_posts.authed
        @unauthed_accounts << "instagram"
      end
    end

    def pinterest_posts(*this)
      #url = []
      #if user_has_provider?('instagram', @user)
        #token = @user.tokens.find_by(provider: 'instagram')
        client = Pinterest::Api.new(this[2], nil)
        begin
          client.get_timeline.posts#.map { |post| Networks::Post.from(post,'instagram', @user) }
        rescue => e
          @unauthed_accounts << "pinterest"
        end
        #url
      #else
      #url
      #end
    end

    def auth_pinterest(pinterest_posts)
      unless pinterest_posts.authed
        @unauthed_accounts << "pinterest"
      end
    end
  end
end
