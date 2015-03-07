module Vimeo
  class Timeline

    attr_reader :authed, :last_post_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts
      timeline = get_timeline(video)
      store_last_post_id(timeline)
      timeline
    end

    def get_video(video_id)
      video.get_info(video_id)
    end

    private

    def video
      @video ||= configure_vimeo(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: 'vimeo')
    end

    def configure_vimeo(tokens)
      @config ||= tokens.configure_vimeo(tokens.access_token, tokens.access_token_secret)
    end

    def get_timeline(video)
      vimeo_timeline = video.get_all(user_tokens.uid)
    end

    def store_last_post_id(timeline)
      if last = timeline.last
        @last_post_id = last.id
      else
        @last_post_id = nil
      end
    end

  end
end