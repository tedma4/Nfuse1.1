class Feed
  include ApplicationHelper
  attr_accessor :params

  attr_reader :unauthed_accounts,
              :twitter_pagination_id,
              :facebook_pagination_id,
              :instagram_max_id,
              :youtube_pagination_id,
              :gplus_pagination_id,
              :vimeo_pagination_id,
              # :pinterest_pagination_id,
              :tumblr_pagination_id,
              :nfuse_pagination_id


  def initialize(user=current_user)
    @user = user
    @unauthed_accounts = []
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

  def construct(params)
    self.params = params
    tw = twitter_posts(params[:twitter_pagination])
    fb = facebook_posts(params[:facebook_pagination_id])
    ig = instagram_posts(params[:instagram_max_id])
    yt = youtube_posts(params[:youtube_pagination])
    gp = gplus_posts(params[:gplus_pagination])
    vp = vimeo_posts(params[:vimeo_pagination])
    up = users_posts(params[:nfuse_post_last_id])
    # pt = pinterest_posts(params[:pinterest_pagination])
    tb = tumblr_posts(params[:tumblr_pagination])
    TimelineConcatenator.new.merge(tw, ig, up, vp, yt, gp, tb, fb ) #, pt, fl, fb
  end

  private

  def users_posts(shout_id)
    if shout_id.nil?
      @_shouts = @user.shouts.limit(200)
      @nfuse_pagination_id = @_shouts.last.id unless @_shouts.empty?
    else
      shout = Shout.find(shout_id)
      @_shouts = @user.shouts.where(['created_at > ?', shout.created_at ])

      if @_shouts.count == 1 && @_shouts.first.id == shout_id.to_i 
        @nfuse_pagination_id = @_shouts.last.id

        @_shouts = []
      end
    end
    @nfuse_shouts = @_shouts.map { |shout| Nfuse::Post.new(shout) }
    @nfuse_shouts
  end

  def twitter_posts(twitter_pagination_id)
    twitter_posts = []
    if user_has_provider?('twitter', @user)
      twitter_timeline = Twitter::Timeline.new(@user)
      begin
        twitter_posts = twitter_timeline.posts(twitter_pagination_id).map { |post| Twitter::Post.from(post, @user) }
        @twitter_pagination_id = twitter_timeline.last_post_id
      rescue => e
        @unauthed_accounts << "twitter"
      end
      twitter_posts
    else
      twitter_posts
    end
  end

  def tumblr_posts(tumblr_pagination_id)
    tumblr_posts = []
    if user_has_provider?('tumblr', @user)
      tumblr_timeline = Tumblr::Timeline.new(@user)
      begin
        tumblr_posts = tumblr_timeline.posts(tumblr_pagination_id)['posts'].map { |post| Tumblr::Posting.from(post, @user) }
        @tumblr_pagination_id = tumblr_timeline.current_page
      rescue => e
        @unauthed_accounts << "tumblr"
      end
      tumblr_posts
    else
      tumblr_posts
    end
  end

  def vimeo_posts(vimeo_pagination_id)
    vimeo_posts = []
    if user_has_provider?('vimeo', @user)
      vimeo_timeline = Vimeo::Timeline.new(@user)
      begin
        vimeo_posts = vimeo_timeline.posts(vimeo_pagination_id).map { |post| Vimeo::Post.from(post, @user) }
        @vimeo_pagination_id = vimeo_timeline.last_post_id
      rescue => e
        @unauthed_accounts << "vimeo"
      end
      vimeo_posts
    else
      vimeo_posts
    end
  end

  def youtube_posts(youtube_pagination_id)
    youtube_posts = []
    if user_has_provider?('google_oauth2', @user)
      youtube_timeline = Youtube::Timeline.new(@user)
      begin
        youtube_posts = youtube_timeline.posts(youtube_pagination_id).map { |post| Youtube::Post.from(post, @user) }
        @youtube_pagination_id = youtube_timeline.current_page
      rescue => e
        @unauthed_accounts << "google_oauth2"
      end
      youtube_posts
    else
      youtube_posts
    end
  end

  def gplus_posts(gplus_pagination_id)
    gplus_posts = []
    if user_has_provider?('gplus', @user)
      gplus_timeline = Gplus::Timeline.new(@user)
      begin
        gplus_posts = gplus_timeline.posts(gplus_pagination_id).items.map { |post| Gplus::Post.from(post, @user) }
        @gplus_pagination_id = gplus_timeline.current_page
      rescue => e
        @unauthed_accounts << "gplus"
      end
      gplus_posts
    else
      gplus_posts
    end
  end

  # def pinterest_posts(pinterest_pagination_id)
  #   pinterest_posts = []
  #   if user_has_provider?('pinterest', @user)
  #     pinterest_timeline = Pinterest::Timeline.new(@user)
  #     begin
  #       pinterest_posts = pinterest_timeline.posts(pinterest_pagination_id).map { |post| Pinterest::Post.from(post, @user) }
  #       @pinterest_pagination_id = pinterest_timeline.last_pic_id
  #     rescue => e
  #       @unauthed_accounts << "pinterest"
  #     end
  #     pinterest_posts
  #   else
  #     pinterest_posts
  #   end
  # end

  def facebook_posts(facebook_pagination_id)
    facebook_posts = []
    if user_has_provider?('facebook', @user)
      facebook_timeline = Facebook::Timeline.new(@user)
      begin
        facebook_posts = facebook_timeline.posts(facebook_pagination_id).map { |post| Facebook::Post.from(post, @user) }
        @facebook_pagination_id = facebook_timeline.current_page
      rescue => e
        @unauthed_accounts << "facebook"
      end
      facebook_posts
    else
      facebook_posts
    end
  end

  def instagram_posts(instagram_max_id)
    if user_has_provider?('instagram', @user)
      instagram_timeline = Instagram::Timeline.new(@user)
      instagram_posts = instagram_timeline.posts(instagram_max_id).map { |post| Instagram::Post.from(post, @user) }
      auth_instagram(instagram_timeline)
      @instagram_max_id = instagram_timeline.pagination_max_id
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