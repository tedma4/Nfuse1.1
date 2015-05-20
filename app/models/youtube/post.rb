require_relative "api"

module Youtube
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

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def provider
      "google_oauth2"
    end

    def created_time
      @post.uploaded_at
    end

    def id
      @post.video_id
    end

    def video_id
      @post.video_id
    end

    def full_name
      @post["user"]["full_name"]
    end

    def link_to_video
      @post["link"]
    end
  end
end