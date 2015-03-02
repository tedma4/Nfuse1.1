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

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'n6107y4oqyomedLDZsMUytEoO', 'jTndXRNGkw6eTI77TJixAxiCuD5D9eKE10GjrzL4WIDwaMquU9'
  provider :instagram, 'd5a97c3cf7b04c70ae234eb9933ef2fd', '2796ff9c9aae40ba9481d19c35f106ee', :scope => 'likes comments relationships'
  provider :facebook, '713308098724920', '4c7016089c6da4d56fa1ac2044a52163', :scope => 'email, public_profile, publish_actions, user_photos, user_status, user_tagged_places, user_videos'
  provider :vimeo, "3a0aa8929985db9ab9e13b8af905fb557c88a3bf", "1d803443422e5eeb806756fd49eb2831240ff387"
  provider :google_oauth2, '585499897487-s0rj3prs5c56ui8vjqnr0l8e66fmco59.apps.googleusercontent.com', 'yQjPXajecmamPWswzrEtAkaA',
    {
      :provider_ignores_state => true,
      :scope => "userinfo.email, userinfo.profile, plus.me, http://gdata.youtube.com",
      :prompt => "consent",
      :image_aspect_ratio => "square",
      :image_size => 50
    }

  #provider :google_plus, '585499897487-r33qnsfp30oc9tijcblj1qcvutqjks9a.apps.googleusercontent.com', 'o7gaMa7Be0uGZzAZ7z-qx73L'
  end
