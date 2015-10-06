module Youtube
  class Timeline

    attr_reader :authed, :current_page
    
  #  client = YouTubeIt::OAuth2Client.new(client_access_token: "access_token", client_refresh_token: "refresh_token", client_id: "client_id", client_secret: "client_secret", dev_key: "dev_key", expires_at: "expiration time")
  #  client.get_all_videos(:user, :time => :today)
  #  client.my_videos
  #  client.my_video(video_id)

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(page = nil)
      timeline = get_timeline(client, page)
      store_page(page)
      timeline
    end

    def get_video(video_id)
      Yt::Video.new id: video_id, auth: client
    end

    def get_post(post_id)
      get_youtube_post(client, post_id)
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

    def get_timeline(client, page)
      if page.nil?
        client.videos.first(15)
      else
        youtube_timeline = client.videos( page: page, count: 25)
        # youtube_timeline.delete_at(0)
        # youtube_timeline
      end
    end

    def get_youtube_post(client, post_id)
      client.videos(post_id)
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