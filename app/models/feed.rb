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

  def posts(twitter_pagination_id, facebook_pagination_id, instagram_max_id, user_id)
    TimelineConcatenator.new.merge(twitter_posts(twitter_pagination_id),
                                   instagram_posts(instagram_max_id),
                                   facebook_posts(facebook_pagination_id),
                                   users_posts(user_id)
    )
  #
  end

  private
  def users_posts(user_id)
    user = User.find(user_id)
    user.shouts.map {|shout|
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
      @shout.content
    end

    def comments_count
      @shout.comments.count
    end

    def like_score
      @shout.get_likes.size
    end

    def dislike_score
      @shout.get_dislikes.size
    end

    def comments
      @shout.comments { |comment| Comment.from(comment) }
    end

    def avatar
      @shout.user.avatar
    end

    def full_name
      @shout.user.full_name
    end

    def new_comment
      @shout.commentable_type.comments.new
    end

    def link?
      @shout.link
    end

    def link
      @shout.link
    end

    def uid
      @shout.uid
    end

    def title
      @shout.title
    end

    def author
      @shout.author
    end

    def duration
      @shout.duration
    end

    def pic?
      @shout.pic
    end
  end

  class Comment
    delegate :created_at, :user, :body, :id, to: :comment

    attr_reader :provider
    attr_accessor :comment

    def initialize(comment)
      @comment = comment
      @provider = "nfuse"
    end

    def created_time
      @comment.created_at
    end
    
    def avatar
      @comment.user.avatar
    end

    def profile
      @comment.user
    end

    def full_name
      @comment.user.full_name
    end

    def body
      @comment.body
    end
  end
end