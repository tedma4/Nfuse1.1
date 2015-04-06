module FLickr
  class Timeline

    attr_reader :authed, :last_vid_id

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
      @client ||= configure_flickr(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: "flickr")
    end

    def configure_flickr(tokens)
      @config ||= tokens.configure_flickr(tokens.access_token, tokens.refresh_token)#, tokens.expiresat)
    end

    def get_timeline(client, max_id)
      if max_id.nil?
        client.my_videos( count: 25)
      else
        flickr_timeline = client.my_videos( max_id: max_id, count: 50)
        flickr_timeline.delete_at(0)
        flickr_timeline
      end
    end

    def store_last_post_id(timeline)
      if last = timeline.last
        @last_vid_id = last.id
      else
        @last_vid_id = nil
      end
    end
  end
end