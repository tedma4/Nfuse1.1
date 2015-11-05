module Flickr
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
      "flickr"
    end

    def created_time
      flickr.photos.getInfo(photo_id: @post.id).dates.taken
    end

    def id
      @post["id"]
    end

    def full_name
      @post["user"]["full_name"]
    end

    def image
      flickr.photos.getSizes(photo_id: @post.id)[3].source
    end

    def link_to_post
      flickr.photos.getInfo(photo_id: @post.id).urls[0]._content
    end

    def text
      @post.title
    end

  end
end