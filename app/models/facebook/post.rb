module Facebook
  class Post < TimelineEntry

    def self.from(facebook_api_hash)
      DefaultPost.from(facebook_api_hash)
    end

    def provider
      "facebook"
    end

    def post_type
      @post.type
    end

  end
end