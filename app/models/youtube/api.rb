module Youtube::Api

  module ClassMethods; end
  
  module InstanceMethods

    def base_uri
      "https://youtube.com/"
    end

    def link_to_video
      base_uri << "#{@client["user"]["screen_name"]}/status/#{@video["id"]}"
    end

    #def user_url
    #  base_uri << "#{@tweet["user"]["screen_name"]}"
    #end

  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end

#
#"https://gdata.youtube.com/feeds/api/users/userId/uploads?max-results=1"
#"https://gdata.youtube.com/feeds/api/users/userId/uploads"
#GET https://www.googleapis.com/youtube/v3/channels?part=contentDetails&mine=true&key={YOUR_API_KEY}
#GET https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&id={ID}&key={YOUR_API_KEY}
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




