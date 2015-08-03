module Nfuse
  class Post
    delegate :created_at, :user, :pic, :id, :commentable, to: :shout

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

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    def comment_count
      @shout.comments.count
    end

    def comments
      @shout.comments { |comment| Comment.from(comment) }
    end

    def avatar
      @shout.user.avatar(:thumb)
    end

    def full_name
      @shout.user.full_name
    end

    def user_name
      @shout.user.user_name
    end

    alias_method :username, :user_name

    def link?
      @shout.link
    end

    def link
      @shout.link
    end

    alias_method :link_to_post, :link

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

    def is_video?
      @shout.is_video
    end

    def video_url
      @shout.snip.url(:medium)
    end

    def is_full_video?
      @shout.is_full_video
    end

    def full_video_url
      @shout.video.url(:medium)
    end

    def user_url
      feed_user_path(@shout.user)
    end

    def commentable
      @shout.comment.commentable
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

    def nfuse_post
      @shout.nfuse_post
    end
  end

end