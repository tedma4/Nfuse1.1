module Youtube
  class Timeline

    attr_reader :authed, :last_vid_id
    
  #  client = YouTubeIt::OAuth2Client.new(client_access_token: "access_token", client_refresh_token: "refresh_token", client_id: "client_id", client_secret: "client_secret", dev_key: "dev_key", expires_at: "expiration time")
  #  client.get_all_videos(:user, :time => :today)
  #  client.my_videos
  #  client.my_video(video_id)

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(max_id = nil)
      timeline = get_timeline(client, max_id)
      store_last_post_id(timeline)
      timeline
    end

    def get_video(video_id)
      client.my_video(video_id)
    end

    private

    def client
      @client ||= configure_youtube(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: "google_oauth2")
    end

    def configure_youtube(tokens)
      @config ||= tokens.configure_youtube(tokens.access_token, tokens.refresh_token)#, tokens.expiresat)
    end

    def get_timeline(client, max_id)
      if max_id.nil?
        client.my_videos( count: 25)
      else
        youtube_timeline = client.my_videos( max_id: max_id, count: 50)
        youtube_timeline.delete_at(0)
        youtube_timeline
      end
    end

    def store_last_post_id(timeline)
      if last = timeline.videos.last
        @last_vid_id = timeline.videos.last.video_id
      else
        @last_vid_id = nil
      end
    end
  end
end