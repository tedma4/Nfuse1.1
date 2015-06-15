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
      @post.published_at
    end

    def id
      @post.id
    end

    alias_method :photo_id, :id
    
    # def video_id
    #   @post.id
    # end

    #TODO gplus api has no easy way to get video author username
    def full_name
      # @post["user"]["full_name"]
      'boo radley'
    end

    def link_to_post
      "https://www.plus.google.com/v=#{@post.id}"
    end
  end
end