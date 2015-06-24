module Tumblr
  class Timeline

    attr_reader :authed, :last_post_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(max_id = nil)
      timeline = get_timeline(client, max_id)
      store_last_post_id(timeline)
      timeline
    end

    def get_post(post_id)
      client.status(post_id)
    end

    #def create_post(post)
    #  client.update(post)
    #end
#
    #def favorite_post(post_id)
    #  client.favorite(post_id)
    #end
#
    #def repost_post(post_id)
    #  client.repost(post_id)
    #end

    private

    def client
      @client ||= configure_tumblr(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: 'tumblr')
    end

    def configure_tumblr(tokens)
      @config ||= tokens.configure_tumblr(tokens.access_token, tokens.access_token_secret)
    end

    def get_timeline(client, max_id)
      if max_id.nil?
        client.user_timeline(:count =>50)
      else
        tumblr_timeline = client.user_timeline(:max_id => max_id, :count => 100)
        tumblr_timeline.delete_at(0)
        tumblr_timeline
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