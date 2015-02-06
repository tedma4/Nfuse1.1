module Facebook

  class Unauthorized < StandardError
  end

  class Api

    attr_reader :facebook_response

    def initialize(access_token, pagination_id)
      @access_token = access_token
      @pagination_id = pagination_id
    end

    def timeline
      create_feed_request.on_complete do |response|
        # block
        @facebook_response = Response.new(response)
        if @facebook_response.success?
          response_success!
        elsif !@facebook_response.authed?
          raise Unauthorized, "This user's token is no longer valid."
        else
          return []
        end
      end

      hydra.queue
      hydra.run
    end

    # Timeline Utilities
    private 

    def response_success!
      @facebook_response.posts_response
      create_poster_recipient_id_request
      create_commenter_id_request
    end

    def hydra
      @hydra ||= Typhoeus::Hydra.hydra
    end

    public
    # URLS

    def post_url(post_content)
      "https://graph.facebook.com/v2.0/me/feed?access_token=#{@access_token}&message=#{post_content}"
    end

    def like_url(post_id)
      "https://graph.facebook.com/v2.0/#{post_id}/likes?access_token=#{@access_token}"
    end

    def create_post_url(post_id)
      "https://graph.facebook.com/v2.0/#{post_id}?access_token=#{@access_token}"
    end

    def create_feed_url
      _url = "https://graph.facebook.com/v2.0/me/feed?limit=15&access_token=#{@access_token}"
      _url << "&until=#{@pagination_id}" unless @pagination_id.nil?
      _url
    end

    def create_post(post_content)
      post_content.gsub!(" ", "+")
      created_post = Typhoeus.post(post_url(post_content))
      get_post_id(created_post)
    end

    def like_post(post_id)
      Typhoeus.post(like_url(post_id))
    end

    def get_post(post_id)
      @facebook_response = []
      post_request = create_post_request(post_id)
      post_request.on_complete do |response|
        fetch_profile_request(response)
      end
      hydra.queue post_request
      hydra.run
    end

    private

    def fetch_profile_request(response)
        @facebook_response = Response.new(response)
        @facebook_response.single_post_response
        create_poster_profile_request
    end

    def get_post_id(created_post)
      Oj.load(created_post.response_body)["id"]
    end

    def create_post_request(post_id)
      Typhoeus::Request.new(created_post_url(post_id))
    end

    def create_feed_request
      Typhoeus::Request.new(create_feed_url)
    end

    def create_poster_profile_request
      profile_picture_request = create_profile_picture_request(get_poster_id)
      profile_picture_request.on_complete do |response|
        @facebook_response.create_poster_profile_picture(response)
      end
      hydra.queue profile_picture_request
    end

    def get_poster_id
      @facebook_response.post["from"]["id"]
    end

    def create_profile_picture_request(id)
      Typhoeus::Request.new("https://graph.facebook.com/#{id}/picture?redirect=false")
    end

    def create_poster_recipient_id_request
      get_recipient_ids.each do |poster_recipient_id|
        to_from_picture_request = create_profile_picture_request(poster_recipient_id)
        to_from_picture_request.on_complete do |poster_recipient_response|
          @facebook_response.create_poster_recipient_hash(poster_recipient_id, poster_recipient_response)
        end
        hydra.queue to_from_picture_request
      end
    end

    def get_recipient_ids
      @facebook_response.create_poster_recipient_ids
    end

    def create_commenter_id_request
      get_commenter_ids.each do |commenter_id|
        comment_picture_request = create_profile_picture_request(commenter_id)
        comment_picture_request.on_complete do |commenter_response|
          @facebook_response.create_commenter_hash(commenter_id, commenter_response)
        end
        hydra.queue comment_picture_request
      end
    end

    def get_commenter_ids
      @facebook_response.create_commenter_ids
    end
  end
  
end