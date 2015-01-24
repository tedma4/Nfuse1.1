module Instagram
  class Unauthorized < StandardError; end

  class Api

    def initialize(access_token, max_id)
      @access_token = access_token
      @max_id = max_id
    end

    def get_timeline
      Response.new(Faraday.get("#{create_url}"))
    end

    def like_post(media_id)
      Typhoeus.post("#{media_api}/#{media_id}/likes?access_token=#{@access_token}")
    end

    def get_post(media_id)
      Response.new(
        Typhoeus.get("#{media_api}/#{media_id}/?access_token=#{@access_token}")
      )
    end

    private
    # reduce the amount of barewords. (strings)

    def api_https_url
      'https://api.instagram.com/v1'
    end

    def media_api
      api_https_url + '/media'
    end

    def users_api
      api_https_url + '/users'
    end

    def create_url
      if @max_id.nil?
        "#{users_api}/self/media/recent/?access_token=#{@access_token}&count=60"
      else
        "#{users_api}/self/media/recent/?access_token=#{@access_token}&max_id=#{@max_id}&count=120"
      end
    end

  end
end
