class Feed
  include ApplicationHelper

  attr_reader :unauthed_accounts

  def initialize(user)
    @user = user
    @unauthed_accounts = []
  end

  def posts(twitter_pagination_id, facebook_pagination_id, instagram_max_id)
    @timeline_calc = TimelineConcatenator.new

    # That ternary operator - they talked about at the last meetup.

    twitter?   ?  t = twitter_posts(twitter_pagination_id) : t = []
    instagram? ?  i = instagram_posts(instagram_max_id)  : i = []
    facebook?  ?  f = facebook_posts(facebook_pagination_id) : f =[]

    @timeline_calc.merge(t, i, f)
  end

  # These really should be in the User model
  # but keeping here for clarity

  def twitter?
    @user.tokens.by_name('twitter').any?
  end

  def facebook?
    @user.tokens.by_name('facebook').any?
  end

  def instagram?
    @user.tokens.by_name('instagram').any?
  end

  #
  # -----------  Twitter
  #
  def twitter_posts(twitter_pagination_id)
      # all methods act like begin; end can contain a rescue
      twitter_timeline
      fetch_twitter_posts
      # This is a catch all for all Twitter errors.
    rescue Twitter::Error => error
      Rails.logger.info "[TWITTER_ERROR]:: #{error}"
      @unauthed_accounts << "twitter"
  end

  # Moving this out into its own method
  # means you know longer have to rely on .post() being called first
  def twitter_pagination_id
    @twitter_pagination_id ||= twitter_timeline.last_post_id
  end

  def twitter_timeline
    @twitter_timeline ||= Twitter::Timeline.new(@user)
  end

  def fetch_twitter_posts
    @twitter_posts ||= @twitter_timeline
                      .posts(twitter_pagination_id)
                      .map { |post| Twitter::Post.from(post) }
  end
  #
  # ------------ Instagram
  #
  def instagram_posts(instagram_max_id)
      instagram_posts = fetch_instagram_posts(instagram_max_id)
      auth_instagram(instagram_timeline)
      instagram_posts
  end

  # Moving this out into its own method
  # means you know longer have to rely on .post() being called first
  def instagram_max_id
    @instagram_max_id ||= instagram_timeline.pagination_max_id
  end

  def fetch_instagram_posts(max_id)
    instagram_timeline.posts(max_id).map { |post| Instagram::Post.from(post) }
  end

  def instagram_timeline
    @instagram_timeline ||= Instagram::Timeline.new(@user)
  end

  def auth_instagram(posts)
    unless posts.authed
      @unauthed_accounts << "instagram"
    end
  end

  #
  # -------------- Facebook
  #
  def facebook_posts(facebook_pagination_id)
      facebook_posts = fetch_facebook_posts(facebook_pagination_id)
      auth_facebook(facebook_timeline)
      facebook_posts
  end

  # Moving these out into their own method
  # means you know longer have to rely on .post() being called first
  def poster_recipient_profile_hash
    @poster_recipient_profile_hash ||= facebook_timeline.poster_recipient_profile_hash
  end

  def commenter_profile_hash
    @commenter_profile_hash ||= facebook_timeline.commenter_profile_hash
  end

  def facebook_pagination_id
    @facebook_pagination_id ||= facebook_timeline.pagination_id
  end

  def fetch_facebook_posts(fb_page_id)
    @fb_posts ||= facebook_timeline.posts(fb_page_id).map { |post| Facebook::Post.from(post) }
  end

  def facebook_timeline
    @fb_timeline ||= Facebook::Timeline.new(@user)
  end

  def auth_facebook(facebook_timeline)
    unless facebook_timeline.authed
      @unauthed_accounts << "facebook"
    end
  end
end