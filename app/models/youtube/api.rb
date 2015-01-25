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