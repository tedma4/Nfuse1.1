class PostsController < ApplicationController
  #This controlls the post process for facebook and twitter

  def create
    if twitter?
      twitter[:tweet] = Twitter::Timeline.new(@user).create_tweet(params[:post])
    end

    if facebook?
      facebook[:post]         = facebook_response.post
      facebook[:picture]      = facebook_response.poster_profile_picture
      facebook[:full_post]    = facebook[:post].merge(facebook[:picture])
    end
    
    render json: {tweet: twitter[:tweet], facebook_post: facebook[:full_post]}
  end

  # Exercise in the power of Hash.
  private

  def facebook_response
    @facebook_response ||= call_facebook_api
  end

  def call_facebook_api
    post_id = facebook_api.create_post(params[:post])
    facebook_api.get_post(post_id)
    facebook_api.facebook_response
  end

  def facebook_api
    @fb_api ||= Facebook::Api.new(fb_token.access_token, nil)
  end

  def fb_token
    current_user.tokens.find_by(provider: 'facebook')
  end

  def twitter?
    params[:twitter] == 'true'
  end

  def facebook?
    params[:facebook] == 'true'
  end

  def facebook
    {}
  end

  def twitter
    {}
  end

end