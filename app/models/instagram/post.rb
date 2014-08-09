module Instagram

  class Post < TimelineEntry

    def self.from(instagram_api_hash)
      new(instagram_api_hash)
    end

    def initialize(post)
      @post = post
      @created_time = Time.at(@post["created_time"].to_i)
    end

    def provider
      "instagram"
    end

    def id
      @post["id"]
    end

    def profile_picture
      @post["user"]["profile_picture"]
    end

    def username
      @post["user"]["username"]
    end

    def user_url
      "http://www.instagram.com/#{username}"
    end

    def low_resolution_image_url
      @post["images"]["low_resolution"]["url"]
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

    def comments_count
      @post["comments"]["count"].to_i
    end

    def comments
      @post["comments"]["data"].map { |comment| Comment.from(comment) }
    end

    def likes_count
      @post["likes"]["count"].to_i
    end

    def type
      @post["type"]
    end

    def video
      @post["videos"]["standard_resolution"]["url"]
    end

  end

end