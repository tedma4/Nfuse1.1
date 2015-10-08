class ActivitiesController < ApplicationController
	def index
	  @activities 	= PublicActivity::Activity.order(created_at: :desc).where(recipient_id: current_user.id,
	                                                                         recipient_type: 'User')
    @post_id      = PublicActivity::Activity.last.parameters[:id]
		@provider 		= PublicActivity::Activity.last.parameters[:provider]
	  # @providers    = Providers.for(current_user)
    notifi        = Notification::Timeline.new(@post_id, @provider, current_user)
    @post_entry     = notifi.single_post(@post_id)
	end
end

#
# def blank_for_now(post_id)
#   case(@provider)
#     when 'twitter'
#       token = current_user.tokens.find_by(provider: 'twitter')
#       configure_twitter(token.access_token, token.access_token_secret)
#       client.status(post_id).map { |post| Twitter::Post.from(post, @user) }
#     when 'facebook'
#       access_token = current_user.tokens.find_by(provider: 'facebook').access_token
#       client = configure_facebook(access_token)
#       client.get_object(post_id).map { |post| Facebook::Post.from(post, current_user) }
#     when 'youtube'
#       token = current_user.tokens.find_by(provider: 'google_oauth2')
#       client = configure_youtube(token.access_token, token.refresh_token)
#       video = Yt::Video.new id: post_id, auth: client
#       video.map {|post| Youtube::Post.from(post, @user) }
#     when 'gplus'
#       uid = current_user.tokens.find_by(provider: 'gplus').uid
#       configure_gplus(uid)
#       post.map { |post| Gplus::Post.from(post, @user) }
#     when 'vimeo'
#       access_token = current_user.tokens.find_by(provider: 'vimeo').access_token
#       user = configure_vimeo(access_token)
#       user.videos.find(id: post_id).map { |post| Vimeo::Post.from(post, @user) }
#     when 'tumblr'
#       token = current_user.tokens.find_by(provider: 'tumblr')
#       client = configure_tumblr(token.access_token, token.access_token_secret)
#       username = client.info['user']['name']
#       client.posts("#{username}.tumblr.com", id: post_id).map { |post| Tumblr::Posting.from(post, @user) }
#     when 'flickr'
#       token = current_user.tokens.find_by(provider: 'flickr').access_token
#       client = configure_flickr(token.access_token, token.access_token_secret)
#       info = client.photos.getInfo(:photo_id => post_id)
#       FlickRaw.url_z(info).map {|post| Flickr::Post.from(post, @user) }
#     when 'instagram'
#       token = current_user.tokens.find_by(provider: 'instagram')
#       instagram_api = Instagram::Api.new(token.access_token, nil)
#       instagram_api.get_post(media_id).map { |post| Instagram::Post.from(post, @user) }
#   end
# end
#
#   def configure_facebook(access_token)
#     app_secret = ENV['facebook_app_secret']
#     client = Koala::Facebook::API.new(access_token, app_secret)
# 		client
#   end
#
#   def configure_twitter(access_token, access_token_secret)
#     client = Twitter::REST::Client.new do |config|
#       config.consumer_key        = ENV["twitter_api_key"]
#       config.consumer_secret     = ENV["twitter_api_secret"]
#       config.access_token        = access_token
#       config.access_token_secret = access_token_secret
#     end
#     client
#   end
#
#   def configure_tumblr(access_token, access_token_secret)
#     Tumblr.configure do |config|
#       config.consumer_key        = ENV['tumblr_consumer_key']
#       config.consumer_secret     = ENV['tumblr_consumer_secret']
#       config.oauth_token         = access_token
#       config.oauth_token_secret  = access_token_secret
#     end
#     client = Tumblr::Client.new#(client: :httpclient)
#   end
#
#   def configure_vimeo(access_token)
#     client = Vmo::Base.new(access_token)
#       user = Vmo::Request.get_user(access_token)
#   end
#
#   # def configure_vimeo(access_token)
#   #   consumer_secret = ENV['vimeo_client_secret']
#   #   consumer_key = ENV['vimeo_client_id']
#   #   client = Vmo::Advanced::Base.new(access_token)
#   #     user = Vmo::Advanced::Video(consumer_secret, consumer_key, access_token )
#   # end
#
#   def configure_youtube(access_token, refresh_token)#, expiresat)
#     Yt.configure do |config|
#       config.client_id = ENV["google_client_id"]
#       config.client_secret = ENV["google_client_secret"]
#     end
#     client = Yt::Account.new(access_token: access_token, refresh_token: refresh_token)
#     client
#   end
#
#   def configure_gplus(uid)
#     GooglePlus.api_key = ENV['youtube_dev_key']
#     client = GooglePlus::Person.get(uid)
#     post = GooglePlus::Activity.get(post_id)
#   end
#
#   def configure_flickr(access_token, access_secret)
#     FlickRaw.api_key=ENV["flickr_key"]
#     FlickRaw.shared_secret=ENV["flickr_secret"]
#     client = FlickRaw::Flickr.new
#     client.access_token = access_token
#     client.access_secret = access_secret
#     client
#   end