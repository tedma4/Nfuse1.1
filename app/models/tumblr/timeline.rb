module Tumblr
  class Timeline

    attr_reader :authed, :cursor
    NUMBER_TO_LOAD = 1
    def initialize(user=current_user)
      @user = user
      @authed = true
      @cursor = 0
    end

    def posts(offset = 0)
      timeline = get_timeline(client, offset)
      store_cursor(offset)
      timeline
    end

    private

    def client
      @client ||= configure_tumblr(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: "tumblr")
    end

    def configure_tumblr(tokens)
      @config ||= tokens.configure_tumblr(tokens.access_token, 
                                          tokens.access_token_secret)
    end

    def my_username
      client.info["user"]["name"]
    end

    def get_timeline(client, offset)
      if offset == 0 || offset.nil?
        tumblr_timeline = client.posts("#{my_username}.tumblr.com", limit: NUMBER_TO_LOAD)
        @cursor += NUMBER_TO_LOAD
        tumblr_timeline
      else
        tumblr_timeline = client.posts("#{my_username}.tumblr.com", offset: @cursor, limit: NUMBER_TO_LOAD)
        @cursor += NUMBER_TO_LOAD
        tumblr_timeline
      end
    end

    def store_cursor(offset)
      if offset.nil?
        @cursor = NUMBER_TO_LOAD
      else
        @cursor += NUMBER_TO_LOAD
      end
    end
  end
end