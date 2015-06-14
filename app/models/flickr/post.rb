require_relative "api"

module Flickr
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
      @post.comments.count
    end

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def provider
      "flickr"
    end

    def created_time
      @post.created_at
    end

    def id
      @post["id"]
    end

    def full_name
      @post["user"]["full_name"]
    end

    def link_to_video
      @post["link"]
    end
  end
end