require_relative 'api'

module Twitter
  class Post < TimelineEntry

  attr_reader :user  
  
  include Api

    def self.from(tweet, user)
      new(tweet, user)
    end

    def initialize(tweet, user)
      @tweet = tweet
      @user = user
    end

    def like_score(id)
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    def id
      @tweet.id
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def link_to_post
      "https://twitter.com/#{username}/status/#{id}"
    end

    def created_time
      @tweet.created_at
    end

    def provider
      "twitter"
    end

    def tweet_id
      @tweet.id
    end

    def tweet_user
      @tweet.user
    end

    #def profile_picture
    #  tweet_user["profile_image_url_https"]
    #end
#
    #def user_name
    #  tweet_user["name"]
    #end
#
    #def screen_name
    #  tweet_user["screen_name"]
    #end

    def has_media?
      @tweet.attrs.has_key? :extended_entities
    end

    def tweet_text
      @tweet.text
    end

    def tweet_video
      if type == "animated_gif"
        @tweet.attrs[:extended_entities][:media][0][:video_info][:variants][0][:url]
      elsif type == "video"
        @tweet.attrs[:extended_entities][:media][0][:video_info][:variants][2][:url]
      end
    end

    def type
      @tweet.attrs[:extended_entities][:media][0][:type]
    end

    #def retweet_count
    #  @tweet["retweet_count"].to_i
    #end
#
    #def favorite_count
    #  @tweet["favorite_count"].to_i
    #end

    #def tweet_image
    #  @tweet['media'][0]['media_url'] if @tweet.fetch('media', nil)
    #end
  
    def tweet_image
      @tweet.attrs[:extended_entities][:media][0][:media_url]
    end
  end
end