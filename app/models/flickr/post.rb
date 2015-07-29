require_relative "api"

module Flickr
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
      "flickr"
    end

    def created_time
      @info ||= flickr.photos.getInfo(photo_id: @post.id)
      utime = @info.dates.posted
      Time.zone.parse(Time.at(utime.to_i).to_s(:db))
    end

    def id
      @post["id"]
    end

    def full_name
      @post["user"]["full_name"]
    end

    def low_resolution_image_url
      flickr.photos.getSizes(photo_id: @post.id)[3].source
    end

    def link_to_post
      @info ||= flickr.photos.getInfo(photo_id: @post.id)
      @info.urls[0]._content
    end

    def caption
      @info ||= flickr.photos.getInfo(photo_id: @post.id)
      @info['description']
    end

  end
end