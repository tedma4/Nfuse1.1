module Vimeo
  class Timeline

    attr_reader :authed, :last_post_id

    def initialize(user=current_user)
      @user = user
      @authed = true
    end

    def posts
      timeline = get_timeline(client)
      store_last_post_id(timeline)
      timeline
    end

    def get_video(video_id)
      client.video(video_id)
    end

    private

    def client
      @client ||= configure_vimeo(user_tokens)
    end

    def user_tokens
      @user_tokens ||= @user.tokens.find_by(provider: 'vimeo')
    end

    def configure_vimeo(tokens)
      @config ||= tokens.configure_vimeo(tokens.access_token, tokens.access_token_secret)
    end


    def get_timeline(client)
      clientv = Vimeo::Advanced::Video.new('3a0aa8929985db9ab9e13b8af905fb557c88a3bf', '1d803443422e5eeb806756fd49eb2831240ff387',
        :token => user_tokens.token,
        :secret => user_tokens.secret)
      @videos = client.clientv.get_all(user_tokens.uid)
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