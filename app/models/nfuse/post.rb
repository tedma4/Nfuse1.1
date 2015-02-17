module Nfuse
  class Post
    delegate :created_at, :user, :pic, :id, :commentable_type, to: :shout

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

    def comments
      @shout.comments { |comment| Comment.from(comment) }
    end

    def avatar
      @shout.user.avatar
    end

    def full_name
      @shout.user.full_name
    end

    def link?
      @shout.link
    end

    def link
      @shout.link
    end

    def is_link?
      @shout.is_link
    end

    def is_link
      @shout.is_link
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

    def is_pic?
      @shout.is_pic
    end

    def pic_url
      @shout.pic.url(:medium)
    end

    def is_snip?
      @shout.is_snip
    end

    def snip
      @shout.snip.url(:original)
    end

    def user_url
      feed_user_path(@shout.user)
    end

    def commentable
      @shout.commentable
    end

    def comment
      @shout.comment
    end

    def url_html
      @shout.url_html
    end

    def url
      @shout.url
    end

    def has_content?
      @shout.has_content
    end

    def has_content
      @shout.has_content
    end

    def current_user?
      @shout.current_user
    end

    def current_user
      @shout.current_user
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