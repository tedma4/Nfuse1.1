module Youtube

	class Post < TimelineEntry

    def self.from(youtube_api)
      new(youtube_api)
    end

    def initialize(post)
      @post = post
      @created_time = Time.at(@post["created_time"].to_i)
    end

    def provider
      "google_oauth2"
    end

    def id
      @post["id"]
    end

    def media_id
      @post["media_id"]
    end

    def profile_picture
      @post["user"]["profile_picture"]
    end

    def full_name
      @post["user"]["full_name"]
    end

    def user_url
      "http://www.instagram.com/#{full_name}"
    end

    def link_to_video
      @post["link"]
    end
  end
end