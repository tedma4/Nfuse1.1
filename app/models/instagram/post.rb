module Instagram

  class Post < TimelineEntry

    attr_reader :user

    def self.from(instagram_api_hash, user)
      new(instagram_api_hash, user)
    end

    def initialize(post, user)
      @post = post
      @created_time = Time.at(@post["created_time"].to_i)
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
      "instagram"
    end

    def id
      @post["id"]
    end

    #def profile_picture
    #  @post["user"]["profile_picture"]
    #end
#
    #def full_name
    #  @post["user"]["full_name"]
    #end
#
    #def user_url
    #  "http://www.instagram.com/#{full_name}"
    #end

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

    #def comments_count
    #  @post["comments"]["count"].to_i
    #end
#
    #def comments
    #  @post["comments"]["data"].map { |comment| Comment.from(comment) }
    #end

    #def likes_count
    #  @post["likes"]["count"].to_i
    #end

    def type
      @post["type"]
    end

    def video
      @post["videos"]["standard_resolution"]["url"]
    end
  end
end