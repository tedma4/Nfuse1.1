class Feed
  include ApplicationHelper
  attr_accessor :params

  attr_reader :poster_recipient_profile_hash,
              :commenter_profile_hash,
              :unauthed_accounts,
              :twitter_pagination_id,
              :facebook_pagination_id,
              :instagram_max_id,
              :youtube_pagination_id,
              :vimeo_pagination_id,
              :nfuse_pagination_id


  def initialize(user=current_user)
    @user = user
    @unauthed_accounts = []
  end

  def posts(twitter_pagination_id, facebook_pagination_id, instagram_max_id, user_id, youtube_pagination_id, vimeo_pagination_id)#, youtube_pagination_id, vimeo_pagination_id
    TimelineConcatenator.new.merge(twitter_posts(twitter_pagination_id),
                                   instagram_posts(instagram_max_id),
                                   facebook_posts(facebook_pagination_id),
                                   youtube_posts(youtube_pagination_id),
                                   vimeo_posts(vimeo_pagination_id),
                                   users_posts(user_id)
                                   )
  end

  def construct(params)
    self.params = params
    tw = twitter_posts(params[:twitter_pagination])
    fb = facebook_posts(params[:facebook_pagination_id])
    ig = instagram_posts(params[:instagram_max_id])
    yt = youtube_posts(params[:youtube_pagination_id])
    vp = vimeo_posts(params[:vimeo_pagination_id])
    up = users_posts(params[:nfuse_post_last_id])
    TimelineConcatenator.new.merge(tw, ig, fb, up, vp, yt )
  end

  private

  def users_posts(shout_id)

    if shout_id.nil?
      @_shouts = @user.shouts.limit(10)
      @nfuse_pagination_id = @_shouts.last.id
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
        @youtube_pagination_id = youtube_timeline.last_vid_id
      rescue => e
        @unauthed_accounts << "google_oauth2"
      end
      youtube_posts
    else
      youtube_posts
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

  def facebook_posts(facebook_pagination_id)
    if user_has_provider?('facebook', @user)
      facebook_timeline = Facebook::Timeline.new(@user)
      facebook_posts = facebook_timeline.posts(facebook_pagination_id).map { |post| Facebook::Post.from(post, @user) }

      auth_facebook(facebook_timeline)
      @poster_recipient_profile_hash = facebook_timeline.poster_recipient_profile_hash
      @commenter_profile_hash = facebook_timeline.commenter_profile_hash
      @facebook_pagination_id = facebook_timeline.pagination_id
      facebook_posts
    else
      []
    end
  end

  def auth_facebook(facebook_timeline)
    unless facebook_timeline.authed
      @unauthed_accounts << "facebook"
    end
  end
end
