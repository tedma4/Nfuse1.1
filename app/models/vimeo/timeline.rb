module Vimeo
  class Timeline
    POST_PAGINATION_COUNT = 5

    attr_reader :authed, :last_post_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end


    def posts(max_id = nil)
      timeline = get_timeline(video, max_id)
      timeline
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

    def config_video_base
      tokens = @config.get_access_token

      Vimeo::Advanced::Video.new(
        ENV["vimeo_client_id"],
        ENV["vimeo_client_secret"],
        token: tokens.token,
        secret: tokens.secret
      )
    end

    def uid(user_tokens)
      user_tokens.uid
    end
    #  video = Vimeo::Advanced::Video.new("consumer_key", "consumer_secret", :token => user.token, :secret => user.secret)
    #  video.get_uploaded("user_id", { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" }) user_id is the vimeo's user_id

    #def get_timeline(video)
    #  vimeo_timeline = video.get_uploaded(uid, { :page => "1", :per_page => "25", :full_response => "0", :sort => "newest" })
    #end

    def get_timeline(video, page)
      configure_vimeo(user_tokens)
      if page == nil
        user = Vmo::Request.get_user_videos(user_tokens.access_token, page: 1, per_page: POST_PAGINATION_COUNT)
        timeline = user.videos
        @last_post_id = 1
      else
        page = page.to_i + 1
        user = Vmo::Request.get_user_videos(user_tokens.access_token, page: page, per_page: POST_PAGINATION_COUNT)
        timeline = user.videos
        @last_post_id = page
      end
      timeline

      # if max_id.nil?
      #   video.get_uploaded(uid, count: 25)
      # else
      #   vimeo_timeline = video.get_uploaded(uid, max_id: max_id, count: 50)
      #   vimeo_timeline.delete_at(0)
      #   vimeo_timeline
      # end
    end

  end
end