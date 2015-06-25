# module Tumblr
#   class Timeline

#     attr_reader :authed, :last_post_id

#     def initialize(user=current_user)
#       @user = user
#       @authed = true
#     end

#     def post(max_id = nil)
#       timeline = get_timeline(client, max_id)
#       store_last_post_id(timeline)
#       timeline
#     end

#     private

#     def client
#       @client ||= configure_tumblr(user_tokens)
#     end

#     def user_tokens
#       @user_tokens ||= @user.tokens.find_by(provider: 'tumblr')
#     end

#     def configure_tumblr(tokens)
#       @config ||= tokens.configure_tumblr(tokens.access_token, 
#                                           tokens.access_token_secret)
#     end

#     def username
#       client.info["user"]["name"]
#     end

#     def get_timeline(client, max_id)
#       if max_id.nil?
#         client.posts("#{username}.tumblr.com", :count => 50)
#       else
#         tumblr_timeline = client.posts("#{username}.tumblr.com",:max_id => max_id, :count => 100)
#         tumblr_timeline.delete_at(0)
#         tumblr_timeline
#       end
#     end

#     def store_last_post_id(timeline)
#       if last = timeline.last
#         @last_post_id = last.id
#       else
#         @last_post_id = nil
#       end
#     end

#   end
# end








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

    def username
      client.info["user"]["name"]
    end

    def get_timeline(client, page)
      if page.nil?
          client.posts("#{username}.tumblr.com")
      else
        username = client.info["user"]["name"]
        tumblr_timeline = client.posts("#{username}.tumblr.com", page: page, count: 50)
      end
    end

    def store_page(page)
      @current_page = page
    end
  end
end