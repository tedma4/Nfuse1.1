module Youtube
  class Timeline

    attr_reader :authed, :current_page
    
  #  client = YouTubeIt::OAuth2Client.new(client_access_token: "access_token", client_refresh_token: "refresh_token", client_id: "client_id", client_secret: "client_secret", dev_key: "dev_key", expires_at: "expiration time")
  #  client.get_all_videos(:user, :time => :today)
  #  client.my_videos
  #  client.my_video(video_id)
    POST_PAGINATION_COUNT = 5
    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(last_post_number = nil)
      timeline = get_timeline(client, last_post_number)
    end

    def get_video(video_id)
      Yt::Video.new id: video_id, auth: client
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

    def get_timeline(client, last_post_number)
      last_post_number = last_post_number.to_i
      if last_post_number.nil? || last_post_number == 0
        youtube_timeline = client.videos.first(POST_PAGINATION_COUNT)
        store_page(POST_PAGINATION_COUNT)
      else
        vids = client.videos
        if vids.count != last_post_number
          youtube_timeline = vids.first(last_post_number + POST_PAGINATION_COUNT)
          if youtube_timeline.count < last_post_number + POST_PAGINATION_COUNT
            num = youtube_timeline.count - last_post_number
            youtube_timeline = youtube_timeline[-num..-1]
          else
            youtube_timeline = youtube_timeline[-POST_PAGINATION_COUNT..-1]
            store_page(last_post_number + POST_PAGINATION_COUNT)
          end
        else
          youtube_timeline = []
        end
      end
      youtube_timeline
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