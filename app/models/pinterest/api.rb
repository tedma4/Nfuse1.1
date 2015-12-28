module Pinterest
  class Unauthorized < StandardError; end

  class Api

    def initialize(access_token, max_id)
      @access_token = access_token
      @max_id = max_id
    end

    def get_timeline
      Response.new(Faraday.get("#{create_url}"))
    end

    private
    # reduce the amount of barewords. (strings)

    def api_https_url
      'https://api.pinterest.com/v1'
    end

    # def media_api
    #   api_https_url + '/media'
    # end

    def pins_api
      api_https_url + '/me'
    end

    def create_url
      if @max_id.nil?
        "#{pins_api}/pins/?access_token=#{@access_token}&fields=created_at,note,url,id,media,link,attribution,image&count=50"
      else
        "#{pins_api}/pins/?access_token=#{@access_token}&fields=created_at,note,url,id,media,link,attribution,image&max_id=#{@max_id}&count=100"
      end
    end

  end
end
