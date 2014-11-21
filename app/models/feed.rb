class Feed
  include ApplicationHelper

  attr_reader :poster_recipient_profile_hash,
              :commenter_profile_hash,
              :unauthed_accounts,
              :twitter_pagination_id,
              :facebook_pagination_id,
              :instagram_max_id

  def initialize(user)
    @user = user
    @unauthed_accounts = []
  end

  def posts(twitter_pagination_id, facebook_pagination_id, instagram_max_id)
    TimelineConcatenator.new.merge(twitter_posts(twitter_pagination_id),
                                   instagram_posts(instagram_max_id),
                                   facebook_posts(facebook_pagination_id),
                                   users_posts
    )
  #
  end

  private
  def users_posts
    @user.shouts.map {|shout|
      Nfuse::Post.new(shout)
    }
  end

  def twitter_posts(twitter_pagination_id)
    twitter_posts = []
    if user_has_provider?('twitter', @user)
      twitter_timeline = Twitter::Timeline.new(@user)
      begin
        twitter_posts = twitter_timeline.posts(twitter_pagination_id).map { |post| Twitter::Post.from(post) }
        @twitter_pagination_id = twitter_timeline.last_post_id
      rescue => e
        @unauthed_accounts << "twitter"
      end
      twitter_posts
    else
      twitter_posts
    end
  end

  def instagram_posts(instagram_max_id)
    if user_has_provider?('instagram', @user)
      instagram_timeline = Instagram::Timeline.new(@user)
      instagram_posts = instagram_timeline.posts(instagram_max_id).map { |post| Instagram::Post.from(post) }
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
      facebook_posts = facebook_timeline.posts(facebook_pagination_id).map { |post| Facebook::Post.from(post) }

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

#
# -------- Copying from Instagram/Facebook/Twitter::Post
#
class Nfuse
  class Post
    delegate :created_at, :user, :pic, :id, to: :shout

    attr_reader :provider
    attr_accessor :shout

    def initialize(shout)
      @shout = shout
      @provider = "nfuse"
    end

    def created_time
      @shout.created_at
    end

    def content
      "image"
    end

  end
end
#
# -------- Copying from Instagram/Facebook/Twitter::Post
#