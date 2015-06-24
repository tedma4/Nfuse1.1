require_relative 'api'

module Tumblr
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

    # 
    def like_score(id)
      # Implement counter cache per / Records
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    def comment_count(id)
      Comment.where(commentable_id: id).count
    end

    # User Object * because delegate is not working.

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
      "tumblr"
    end

    def post_id
      @post["id"]
    end

    def post_user
      @post['user']
    end

    #def profile_picture
    #  post_user["profile_image_url_https"]
    #end
#
    #def user_name
    #  post_user["name"]
    #end
#
    #def screen_name
    #  post_user["screen_name"]
    #end

    def post_text
      @post["text"]
    end

    #def repost_count
    #  @post["repost_count"].to_i
    #end
#
    #def favorite_count
    #  @post["favorite_count"].to_i
    #end

    #def post_image
    #  @post['media'][0]['media_url'] if @post.fetch('media', nil)
    #end

    def post_image
      if @post["media"].present?
        @post["media"][0]["media_url"]
      else
        nil
      end
    end
  end
end