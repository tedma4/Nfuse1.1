module Instagram

  class Timeline

    attr_reader :authed, :pagination_max_id

    def initialize(user)
      @user = user
      @authed = true
    end

    def posts(max_id)
      token = @user.tokens.find_by(provider: 'instagram')
      instagram_api = Api.new(token.access_token, max_id)
      posts = []
      begin
        if max_id == -1
          posts = []
          @pagination_max_id = -1
        else
          timeline = instagram_api.get_timeline
          posts = timeline.posts
          @pagination_max_id = timeline.pagination_max_id
        end
      rescue Unauthorized
        @authed = false
      end
      posts
    end
  end
end