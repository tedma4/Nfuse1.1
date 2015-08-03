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
      # wall = api.get_connections("me", "feed", since: 1379593891)
      # wall.next_page(since: 1379593891)

      # Returns the feed items for the currently logged-in user as a GraphCollection
      # feed = @graph.get_connections("me", "feed")
      # feed.each {|f| do_something_with_item(f) } # it's a subclass of Array
      # next_feed = feed.next_page

      # You can also get an array describing the URL for the next page: [path, arguments]
      # This is useful for storing page state across multiple browser requests
      # next_page_params = feed.next_page_params
      # page = @graph.get_page(next_page_params)

      if page.nil?
        #client.get_object("me")
        client.get_connections("me", "posts").first(15)
      else
        facebook_timeline = client.get_connections("me", "posts", page: page, :count => 50)
      end
    end

    def store_last_post_id(page)
      @current_page = page
    end

  end
end