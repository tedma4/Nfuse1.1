#"google_oauth2"
#      @authentication = Authentication.where(uid: auth["uid"])
#      user = @authentication.last.user 
#      user.google_uid = auth["uid"]
#      user.google_fullname = auth["info"]["name"]
#  		#user.google_email = auth["info"]["email"] #email repeat
#  		#user.google_first_name = auth["info"]["first_name"] #same repeat 
#  		user.google_last_name = auth["info"]["last_name"]
#  		user.google_image = auth["info"]["image"]										#urls is a hash of links
#  		user.google_plus_profile = auth["info"]["urls"]["Google"] #look into possibly saving more than url for ppl with more links
#  		user.google_token = auth["credentials"]["token"]
#      user.google_refresh_token = auth["credentials"]["refresh_token"]
#      user.google_expires_at = auth["credentials"]["expires_at"]
#      user.google_expires = auth["credentials"]["expires"]
#      user.google_id = auth["extra"]["raw_info"]["id"]
#      user.google_email = auth["extra"]["raw_info"]["email"]
#      user.google_verified_email = auth["extra"]["raw_info"]["verified_email"]
#      user.google_fullname = auth["extra"]["raw_info"]["fullname"]
#  		user.google_given_name = auth["extra"]["raw_info"]["given_name"] #repeat of first name
#  		user.google_family_name = auth["extra"]["raw_info"]["family_name"] #repeat of last name
#  		user.google_link = auth["extra"]["raw_info"]["link"]
#  		user.google_picture = auth["extra"]["raw_info"]["picture"]
#  		user.google_gender = auth["extra"]["raw_info"]["gender"]
#  		user.google_locale = auth["extra"]["raw_info"]["locale"]
#  		user.save!
#      user.save_videos
#    end
#  end
#
#  def youtube_client 
#   YouTubeIt::OAuth2Client.new(
#     client_access_token: google_token, client_refresh_token: google_refresh_token,
#     client_id: ENV['GOOGLE_CLIENT_ID'], client_secret: ENV['GOOGLE_CLIENT_SECRET'], 
#     dev_key: ENV['GOOGLE_DEV_KEY'], expires_at: google_expires_at)
# end 
#
# def save_videos
#  uploads = self.youtube_client.my_videos(:user => google_fullname)
#  uploads.videos.each do |upload|
#    video = Video.find_or_create_by(unique_id: upload.unique_id) 
#    video.unique_id = upload.unique_id 
#    video.description = upload.description
#    video.author = upload.author.name
#    video.thumbnail = upload.thumbnails[0].url
#    video.embeddable = upload.embeddable?
#    video.published_at = upload.published_at
#    video.save_iframe
#    self.videos << video
#  end 
#end

#module Youtube
#  class Unauthorized < StandardError; end
#
#  class Api
#
#    def initialize(access_token, max_id)
#      @access_token = access_token
#      @max_id = max_id
#    end
#
#    def get_timeline
#      Response.new(Faraday.get("#{create_url}"))
#    end
#
#    def like_post(media_id)
#      Typhoeus.post("#{media_api}/#{media_id}/likes?access_token=#{@access_token}")
#    end
#
#    def get_post(media_id)
#      Response.new(
#        Typhoeus.get("#{media_api}/#{media_id}/?access_token=#{@access_token}")
#      )
#    end
#
#    private
#    # reduce the amount of barewords. (strings)
#
#    def api_https_url
#      'https://api.instagram.com/v1'
#    end
#
#    def media_api
#      api_https_url + '/media'
#    end
#
#    def users_api
#      api_https_url + '/users'
#    end
#
#    def create_url
#      if @max_id.nil?
#        "#{users_api}/self/media/recent/?access_token=#{@access_token}&count=60"
#      else
#        "#{users_api}/self/media/recent/?access_token=#{@access_token}&max_id=#{@max_id}&count=120"
#      end
#    end
#  end
#end
#

#!/usr/bin/ruby

#require 'rubygems'
#require 'google/api_client'
## The oauth/oauth_util code is not part of the official Ruby client library. 
## Download it from:
## http://samples.google-api-ruby-client.googlecode.com/git/oauth/oauth_util.rb
#require 'oauth/oauth_util'
#
#
## This OAuth 2.0 access scope allows for read-only access to the authenticated
## user's account, but not other types of account access.
#YOUTUBE_READONLY_SCOPE = 'https://www.googleapis.com/auth/youtube.readonly'
#YOUTUBE_API_SERVICE_NAME = 'youtube'
#YOUTUBE_API_VERSION = 'v3'
#
#client = Google::APIClient.new
#youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
#
#auth_util = CommandLineOAuthHelper.new(YOUTUBE_READONLY_SCOPE)
#client.authorization = auth_util.authorize()
#
## Retrieve the "contentDetails" part of the channel resource for the
## authenticated user's channel.
#channels_response = client.execute!(
#  :api_method => youtube.channels.list,
#  :parameters => {
#    :mine => true,
#    :part => 'contentDetails'
#  }
#)
#
#channels_response.data.items.each do |channel|
#  # From the API response, extract the playlist ID that identifies the list
#  # of videos uploaded to the authenticated user's channel.
#  uploads_list_id = channel['contentDetails']['relatedPlaylists']['uploads']
#
#  # Retrieve the list of videos uploaded to the authenticated user's channel.
#  playlistitems_response = client.execute!(
#    :api_method => youtube.playlist_items.list,
#    :parameters => {
#      :playlistId => uploads_list_id,
#      :part => 'snippet',
#      :maxResults => 50
#    }
#  )
#
#  puts "Videos in list #{uploads_list_id}"
#
#  # Print information about each video.
#  playlistitems_response.data.items.each do |playlist_item|
#    title = playlist_item['snippet']['title']
#    video_id = playlist_item['snippet']['resourceId']['videoId']
#
#    puts "#{title} (#{video_id})"
#  end
#
#  puts
#end
#
#
#"https://gdata.youtube.com/feeds/api/users/userId/uploads?max-results=1"
#"https://gdata.youtube.com/feeds/api/users/userId/uploads"