module Youtube
  class Unauthorized < StandardError; end
  
  class Api

    include HTTParty

    def initialize(access_token, max_id)
      @access_token = access_token
      @max_id = max_id
      @key = 'AIzaSyDURKK2l5VPmwaj3b3DtXaNg9HDB79syrI'
    end

  def refresh_token(token)

    response = HTTParty.post('https://accounts.google.com/o/oauth2/token', 
      :body => { 
        :grant_type => 'refresh_token', 
        :refresh_token => token.refresh_token, 
        :client_id => '585499897487-s0rj3prs5c56ui8vjqnr0l8e66fmco59.apps.googleusercontent.com', 
        :client_secret => 'yQjPXajecmamPWswzrEtAkaA'}
    )
    refreshhash = JSON.parse(response.body)
    token.token = refreshhash['access_token']
    token.expiresat = DateTime.now + refreshhash["expires_in"].to_i.seconds
    token.save!
    token.token

  end

  def token_expired?(access_token)
    if access_token.expiresat 
      expiry = Time.at(access_token.expiresat)
    else
      expiry = Time.now + 2.days
    end 
      return true if expiry < Time.now ## expired token, so we should quickly return
      access_token.expiresat = expiry
      access_token.save if access_token.changed?
      false # token not expired. 
  end

    def api_https_url
      'https://www.googleapis.com/youtube/v3'
    end

    def get_channels_for_user
      if token_expired?(access_token)
        @access_token = access_token.refresh_token
      end
      channel = HTTParty.get("#{api_https_url}/channels?part=id&mine=true&access_token=#{@access_token}&key=#{@key}")
    	channel['items'].first['id']
    end

    # get upload playlist from channel
    def get_uploads_playlist_items(playlist_id)
      playlists = HTTParty.get("#{api_https_url}/channels?part=id%2C+contentDetails&id=#{playlist_id}&access_token=#{@access_token}&key=#{@key}")
    	@playlist_items = playlists['items'].first['contentDetails']['relatedPlaylists']['uploads']
    end

    # fetch videos from a playlist
    def get_playlist_items(playlist_items, max_id)
      playlist = HTTParty.get("#{create_url}")

      #video_hash = []
      #playlist['items'].each do |item|
#
      #  video_hash << { "title" => item["snippet"]["title"],
      #  "video_id" => item["contentDetails"]["videoId"] }
      #end
      #video_hash
    end

    def create_url
      if @max_id.nil?
        "#{api_https_url}/playlistItems?part=id%2Csnippet%2CcontentDetails&playlistId=#{playlist_items}&access_token=#{@access_token}&maxResults=5&key=#{@key}"
      else
        "#{api_https_url}/playlistItems?part=id%2Csnippet%2CcontentDetails&playlistId=#{playlist_items}&access_token=#{@access_token}&max_id=#{@max_id}&maxResults=25&key=#{@key}"
      end
    end

    def get_videos_for
      playlist_id = get_channels_for_user
      playlist_items = get_uploads_playlist_items(playlist_id)

      get_playlist_items(playlist_items, max_id)
    end
  end
end
##
#
##"https://gdata.youtube.com/feeds/api/users/userId/uploads?max-results=1"
##"https://gdata.youtube.com/feeds/api/users/userId/uploads"
##GET https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true&key={YOUR_API_KEY}
##GET https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&id={ID}&key={YOUR_API_KEY}
#
#
#
#
##The code sample below calls the API's playlistItems.list method to retrieve a list of videos uploaded 
##to the channel associated with the request. The code also calls the channels.list method with the mine 
##parameter set to true to retrieve the playlist ID that identifies the channel's uploaded videos.
#
##
#require 'rubygems'
#require 'google/api_client'
#require 'oauth/oauth_util'
#
#YOUTUBE_SCOPE = 'https://www.googleapis.com/auth/youtube'
#YOUTUBE_API_SERVICE_NAME = 'youtube'
#YOUTUBE_API_VERSION = 'v3'
#
#client = Google::APIClient.new
#youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
#
#auth_util = CommandLineOAuthHelper.new(YOUTUBE_SCOPE)
#client.authorization = auth_util.authorize()
#channels_response = client.execute!(
#  :api_method => youtube.channels.list,
#  :parameters => {
#    :mine => true,
#    :part => 'contentDetails'
#  }
#)
#
#channels_response.data.items.each do |channel|
#  uploads_list_id = channel['contentDetails']['relatedPlaylists']['uploads']
#
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




