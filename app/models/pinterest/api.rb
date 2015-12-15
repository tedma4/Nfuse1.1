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

    def users_api
      api_https_url + '/me'
    end

    def create_url
      if @max_id.nil?
        "#{users_api}/pins/?access_token=#{@access_token}&count=50"
      else
        "#{users_api}/pins/?access_token=#{@access_token}&max_id=#{@max_id}&count=100"
      end
    end

  end
end
