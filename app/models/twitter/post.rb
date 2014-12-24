module Twitter
  class Post < TimelineEntry

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

    def profile_picture
      @tweet["user"]["profile_image_url_https"]
    end

    def user_name
      @tweet["user"]["name"]
    end

    def user_url
      "https://twitter.com/#{@tweet["user"]["screen_name"]}"
    end

    def screen_name
      @tweet["user"]["screen_name"]
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

    def link_to_tweet
      "https://twitter.com/#{@tweet["user"]["screen_name"]}/status/#{@tweet["id"]}"
    end

    def tweet_image
      if @tweet["media"].present?
        @tweet["media"][0]["media_url"]
      else
        nil
      end
    end
  end
end