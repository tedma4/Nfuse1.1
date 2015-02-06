require_relative 'api'

module Twitter
  class Post < TimelineEntry
  
  include Api

    def self.from(tweet)
      new(tweet)
    end

    def initialize(tweet)
      @tweet = tweet
    end

    def created_time
      @tweet.created_at
    end

    def provider
      "twitter"
    end

    def tweet_id
      @tweet["id"]
    end

    def tweet_user
      @tweet['user']
    end

    def profile_picture
      tweet_user["profile_image_url_https"]
    end

    def user_name
      tweet_user["name"]
    end

    def screen_name
      tweet_user["screen_name"]
    end

    def tweet_text
      @tweet["text"]
    end

    def retweet_count
      @tweet["retweet_count"].to_i
    end

    def favorite_count
      @tweet["favorite_count"].to_i
    end

    def tweet_image
      @tweet['media'][0]['media_url'] if @tweet.fetch('media', nil)
    end
  end
end