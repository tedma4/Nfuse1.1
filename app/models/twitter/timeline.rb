module Twitter
  class Timeline

    attr_reader :authed, :last_post_id

    def initialize(user=current_user)
      @user    = user
      @authed  = true
    end

    def posts(max_id = nil)
      timeline = get_timeline(client, max_id)
      store_last_post_id(timeline)
      timeline
    end

    def get_tweet(post_id)
      get_twitter_post(client, post_id)
    end

    private

    def client
      @client ||= configure_twitter(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: 'twitter')
    end

    def configure_twitter(tokens)
      @config ||= tokens.configure_twitter(tokens.access_token, tokens.access_token_secret)
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

    def get_twitter_post(client, post_id)
      client.status(post_id)
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