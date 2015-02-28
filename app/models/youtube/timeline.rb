module Youtube

  class Timeline

    attr_reader :authed, :last_vid_id

    def initialize(user)
      @user = user
      @authed = true
    end

    def posts(max_id)
      token = @user.tokens.find_by(provider: 'google_oauth2')
      youtube_api = Api.new(token.access_token, max_id)
      posts = []
      begin
        timeline = youtube_api.get_videos_for
        posts = timeline.posts
          @last_vid_id = timeline.last_vid_id
      rescue Unauthorized
        @authed = false
      end
      posts
    end
  end
end