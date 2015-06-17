require_relative "api"

module Gplus
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
      "gplus"
    end

    def created_time
      @post.published
    end

    def id
      @post.id
    end

    
    # def video_id
    #   @post.id
    # end

    #TODO gplus api has no easy way to get video author username

    def image_url
      @post["images"]
    end

    def full_name
        @post.actor.display_name
    end

    def caption
      @post["caption"]
    end

    def caption_text
      @post["caption"]["text"]
    end

    def link_to_post
      @post["link"]
    end

    def type
      @post["ObjectType"]
    end

    def video
      @post["videos"]
    end
  end
end