class Notifications
  include ApplicationHelper
  attr_accessor :params

  def self.from(post_id, provider)
    new(post_id, provider)
  end

  def initialize(user=current_user, post_id, provider)
    @user = user
    @post_id = post_id
    @provider = provider
  end

  def provider
    @provider
  end

  def posts
    NotificationsConcatenator.new.merge(twitter_posts,
                                        instagram_posts,
                                        facebook_posts,
                                        youtube_posts,
                                        gplus_posts,
                                        vimeo_posts,
                                        flickr_posts,
                                        tumblr_posts,
                                        users_posts
                                        )
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
    NotificationsConcatenator.new.merge(tw, ig, up, vp, yt, fl, gp, tb, fb ) #, pt, fl, fb
  end

  private

  def users_posts
    @_shout = @user.shouts.find(post_id)
    @nfuse_shouts = @_shout.map { |shout| Nfuse::Post.new(shout) }
  end

  def facebook_posts
    facebook_notification = Facebook::Timeline.new(@user)
    facebook_notification.get_post(@post_id).map { |post| Facebook::Post.from(post, @user) }
  end

  def twitter_posts
    if @provider = 'twitter'
    twitter_notification = Twitter::Timeline.new(@user)
    twitter_notification.get_tweet(@post_id).map { |post| Twitter::Post.from(post, @user) }

    end
  end

  def tumblr_posts
    tumblr_notification = Tumblr::Timeline.new(@user)
    tumblr_notification.get_post(@post_id)['posts'].map { |post| Tumblr::Posting.from(post, @user) }
  end

  def vimeo_posts
    vimeo_notification = Vimeo::Timeline.new(@user)
    vimeo_notification.get_post(@post_id).map { |post| Vimeo::Post.from(post, @user) }
  end

  def youtube_posts
    youtube_notification = Youtube::Timeline.new(@user)
    youtube_notification.get_post(@post_id).map { |post| Youtube::Post.from(post, @user) }
  end

  def gplus_posts
    gplus_notification = Gplus::Timeline.new(@user)
    gplus_notification.get_post(@post_id).items.map { |post| Gplus::Post.from(post, @user) }
  end

  def flickr_posts
    flickr_notification = Flickr::Timeline.new(@user)
    flickr_notification.get_post(@post_id).map { |post| Flickr::Post.from(post, @user) }
  end

  def instagram_posts
    instagram_notification = Instagram::Timeline.new(@user)
    instagram_notification.get_post(@post_id).map { |post| Instagram::Post.from(post, @user) }
  end
end

class NotificationsConcatenator

  def merge(twitter_notification, instagram_notification, nfuse_notification, vimeo_notification_notification, youtube_notification, flickr_notification, gplus_notification, tumblr_notification, facebook_notification)#, pinterest_timeline
    (twitter_notification + instagram_notification + nfuse_notification + vimeo_notification + youtube_notification + flickr_notification + gplus_notification + tumblr_notification + facebook_notification)
  end

end