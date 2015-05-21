# Twitter
# API key	n6107y4oqyomedLDZsMUytEoO
# API secret	jTndXRNGkw6eTI77TJixAxiCuD5D9eKE10GjrzL4WIDwaMquU9
# Access token	2525729819-vzV2pFCEijTs2PRrTr0P5vkmSHw1rDf9HhaPMJZ
# Access token secret	GWdCHUTzKC5s7XkERiDQrwZoeQwYVrSWCrHxiiPiIBfmP
# 
# Facebook
# App ID 713308098724920
# App Secret 4c7016089c6da4d56fa1ac2044a52163
# 
# Instagram
# CLIENT ID	d5a97c3cf7b04c70ae234eb9933ef2fd
# CLIENT SECRET	2796ff9c9aae40ba9481d19c35f106ee
# 
# YouTube
# Dev Key AI39si5tETPAcvSl00_0nrLcd2sC7dfDddSCqYtRVPE7pBwf1Ajf5SusGyLhrd3KGT7TqUuHJDBtI6GYxDgfVQK9Jkk0haSOKg
# 
# Vimeo
# CLIENT ID 3a0aa8929985db9ab9e13b8af905fb557c88a3bf
# CLIENT SECRET 1d803443422e5eeb806756fd49eb2831240ff387
# 
# Flickr
# Key: ec04c20311cc5a72e44ab79d78120e05
# Secret: 139707d9a2d0a8a0
#
# Pinterest
# Client_secret: a6b3c1d5
# id: Nfuse11

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,       ENV["twitter_api_key"],          ENV["twitter_api_secret"]
  provider :instagram,     ENV["instagram_client_id"],      ENV["instagram_client_secret"], scope: 'likes comments relationships'
  provider :facebook,      ENV["facebook_app_id"],          ENV["facebook_app_secret"],     scope: 'email, public_profile, publish_actions, user_photos, user_status, user_tagged_places, user_videos'
  provider :vimeo,         ENV["vimeo_client_id"],          ENV["vimeo_client_secret"]
  provider :flickr,        ENV["flickr_client_id"],         ENV["flickr_client_secret"],    scope: 'read'
  provider :pinterest,     ENV["pinterest_client_secret"], ENV["pinterest_id"]
  provider :google_oauth2, ENV["google_client_id"],         ENV["google_client_secret"],
    {
      :provider_ignores_state => true,
      :scope => "userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com",
      :prompt => "consent",
      :image_aspect_ratio => "square",
      :image_size => 50
    }

  #provider :google_plus, '585499897487-r33qnsfp30oc9tijcblj1qcvutqjks9a.apps.googleusercontent.com', 'o7gaMa7Be0uGZzAZ7z-qx73L'
  end
