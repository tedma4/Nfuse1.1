module Tumblr
  class Timeline

    attr_reader :authed, :current_page

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(page = nil)
      timeline = get_timeline(client, page)
      store_page(page)
      timeline
    end

    def get_post(post_id)
      get_tumblr_post(client, post_id)
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

    def get_timeline(client, page)
      if page.nil?
          client.posts("#{my_username}.tumblr.com")
      else
        username = client.info["user"]["name"]
        tumblr_timeline = client.posts("#{username}.tumblr.com", page: page, count: 50)
      end
    end

    def get_tumblr_post(client, post_id)
      client.posts(post_id)
    end

    def store_page(page)
      @current_page = page
    end
  end
end