module Facebook
  class Timeline

    attr_reader :authed, :current_page

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(page = nil)
      timeline = get_timeline(client, page)
      store_last_post_id(page)
      timeline
    end
    private

    def client
      @client ||= configure_facebook(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: 'facebook')
    end

    def configure_facebook(tokens)
      @config ||= tokens.configure_facebook(tokens.access_token)
    end

    def get_timeline(client, page)
      if page.nil?
        #client.get_object("me")
        client.get_connections("me", "posts").first(50)
      else
        facebook_timeline = client.get_connections("me", "posts", page: page, :count => 50)
      end
    end

    def store_last_post_id(page)
      @current_page = page
    end

  end
end