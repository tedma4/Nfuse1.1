module Facebook
  class Timeline

    attr_reader :authed, :poster_recipient_profile_hash, :commenter_profile_hash, :pagination_id

    def initialize(user)
      @user = user
      @authed = true
    end

    def posts(pagination_id)
      token = user_tokens
      facebook_api = Api.new(token.access_token, pagination_id)
      begin
        facebook_api.timeline
      rescue Unauthorized
        @authed = false
      end
      @poster_recipient_profile_hash = facebook_api.facebook_response.poster_recipient_profile_hash
      @commenter_profile_hash = facebook_api.facebook_response.commenter_profile_hash
      @pagination_id = facebook_api.facebook_response.pagination_id
      facebook_api.facebook_response.posts
    end

    private

    def user_tokens
      @user.tokens.find_by(provider: 'facebook')
    end

  end
end