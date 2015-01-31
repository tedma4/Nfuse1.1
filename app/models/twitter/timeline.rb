module Twitter
  class Timeline

    attr_reader :authed,
                :last_post_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(max_id = nil)
      tokens = user_tokens
      client = configure_twitter(tokens)
      timeline = get_timeline(client, max_id)
      store_last_post_id(timeline)
      timeline
    end

    def get_tweet(tweet_id)
      tokens = user_tokens
      client = configure_twitter(tokens)
      client.status(tweet_id)
    end

    def create_tweet(tweet)
      tokens = user_tokens
      client = configure_twitter(tokens)
      client.update(tweet)
    end

    def favorite_tweet(tweet_id)
      tokens = user_tokens
      client = configure_twitter(tokens)
      client.favorite(tweet_id)
    end

    def retweet_tweet(tweet_id)
      tokens = user_tokens
      client = configure_twitter(tokens)
      client.retweet(tweet_id)
    end

    private

    def user_tokens
      @user.tokens.find_by(provider: 'twitter')
    end

    def configure_twitter(tokens)
      tokens.configure_twitter(tokens.access_token, tokens.access_token_secret)
    end

    def get_timeline(client, max_id)
      if max_id.nil?
        client.user_timeline(:count =>50)
      else
        twitter_timeline = client.user_timeline(:max_id => max_id, :count => 100)
        twitter_timeline.delete_at(0)
        twitter_timeline
      end
    end

    def store_last_post_id(timeline)
      if last = timeline.last
        @last_post_id = last.id
      else
        @last_post_id = nil
      end
    end
  end
end
