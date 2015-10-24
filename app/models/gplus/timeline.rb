module Gplus
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

    private
    # Gem documents https://github.com/seejohnrun/google_plus
    # Google doc for gplus that says to use list.Activities for user posts https://developers.google.com/+/domains/posts/reading
    # might need to use googleoauth2 for authentication

    def client
      @client ||= configure_gplus(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: "gplus")
    end

    def configure_gplus(tokens)
      @config ||= tokens.configure_gplus(tokens.uid.to_s, tokens.access_token)
    end

    def get_timeline(client, page)
      if page.nil?
          client.list_activities
      else
        gplus_timeline = client.list_activities.items( page: page, count: 50)
        # gplus_timeline.delete_at(0)
        # gplus_timeline
      end
    end

    def store_page(page)
      @current_page = page
      # if last = timeline.to_a.last.id
      #   @last_vid_id = timeline.last.id
      # else
      #   @last_vid_id = nil
    end
  end
end