module Youtube
	class Post < TimelineEntry

  attr_reader :user

    def self.from(post, user)
      new(post, user)
    end

    def initialize(post, user)
      @post = post
      @user = user
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).size
    end

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def provider
      "youtube"
    end

    def created_time
      @post.published_at
    end

    def text
      @post.description
    end

    def id
      @post.id
    end

    alias_method :video_id, :id
    
    # def video_id
    #   @post.id
    # end

    #TODO youtube api has no easy way to get video author username
    #https://developers.google.com/youtube/v3/docs/videos
    def full_name
      # @post["user"]["full_name"]
      'boo radley'
    end

    def link_to_video
      "https://www.youtube.com/watch?v=#{@post.id}"
    end

    alias_method :link_to_post, :link_to_video

  end
end