module Vimeo
  class Timeline

    attr_reader :authed, :last_post_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts(per_page = nil)
      timeline = get_timeline(video, per_page)
      store_last_post_id(timeline)
      timeline
    end

    def get_video(video_id)
      video.get_uploaded(video_id)
    end

    def get_info(video_id)
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

    #def get_timeline(video)
    #  vimeo_timeline = video.get_all(user_tokens.uid)
    #end

    def get_timeline(video, per_page)
      if per_page.nil?
        video.get_all(user_tokens.uid, :count =>50)
      else
        vimeo_timeline = video.get_all(user_tokens.uid, :per_page => per_page, :count => 100)
        vimeo_timeline.delete_at(0)
        vimeo_timeline
      end
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