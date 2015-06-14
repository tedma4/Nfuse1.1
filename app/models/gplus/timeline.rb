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

    def get_video(video_id)
      Yt::Video.new id: video_id, auth: client
    end

    private

    def client
      @client ||= configure_gplus(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: "google_oauth2")
    end

    def configure_gplus(tokens)
      @config ||= tokens.configure_gplus(tokens.access_token, tokens.refresh_token)#, tokens.expiresat)
    end

    def get_timeline(client, page)
      if page.nil?
        client.videos
      else
        gplus_timeline = client.videos( page: page, count: 50)
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