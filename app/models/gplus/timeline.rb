module Gplus
  class Timeline

    attr_reader :authed, :current_page

    POST_PAGINATION_COUNT = 1

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(page = nil)
      get_timeline(client, page)
    end

    def get_pic(post_id)
      person = GooglePlus::Person.get(123)
      activites = person.list_activities.items
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
      page = page.to_i
      if page.nil? || page == 0
        timeline = client.list_activities.items(max_results: POST_PAGINATION_COUNT)
        store_page(POST_PAGINATION_COUNT)
      else
        total = client.list_activities.items.count
        if total > page
          timeline = client.list_activities.items(max_results: (page + POST_PAGINATION_COUNT))
          #true if you requested more posts than there are left
          if timeline.count < page + POST_PAGINATION_COUNT
            num = timeline.count - page
            timeline = timeline[-num..-1]
            store_page(total)
          else
            timeline = timeline[-POST_PAGINATION_COUNT..-1]
            store_page(page + POST_PAGINATION_COUNT)
          end
        else
          timeline = []
        end
      end
      timeline
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