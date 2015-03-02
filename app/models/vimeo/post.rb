module Vimeo
	class Post < TimelineEntry

	  #def self.get_client
	  #   Vimeo.new(:access_token => user.tokens.find_by(provider: "vimeo").token)
	  #end

    def self.from(post)
      new(post)
    end

    def initialize(post)
      @post = post
    end

    def created_time
      @post.created_at
    end

    def provider
      "twitter"
    end

    def post_id
      @post["id"]
    end

    def post_user
      @post['user']
    end

    def profile_picture
      post_user["profile_image_url_https"]
    end

    def user_name
      post_user["name"]
    end

    def screen_name
      post_user["screen_name"]
    end

    def post_text
      @post["text"]
    end

    def repost_count
      @post["repost_count"].to_i
    end

    def favorite_count
      @post["favorite_count"].to_i
    end

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