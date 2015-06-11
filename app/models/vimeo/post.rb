require_relative "api"

module Vimeo
	class Post < TimelineEntry

    attr_reader :user

    include Api

    def self.from(post, user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    def comment_count
      Comment.where(commentable_id: id).count
    end

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def created_time
      @post.created_at
    end

    def provider
      "vimeo"
    end

    def id
      @post["id"]
    end

    def video_id
      @post["video_id"]
    end

    def post_user
      @post['user']
    end

    #def post_image
    #  @post['media'][0]['media_url'] if @post.fetch('media', nil)
    #end

    #def post_image
    #  if @post["media"].present?
    #    @post["media"][0]["media_url"]
    #  else
    #    nil
    #  end
    #end
  end
end