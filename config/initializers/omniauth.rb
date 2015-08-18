Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,       ENV["twitter_api_key"],          ENV["twitter_api_secret"]
  provider :instagram,     ENV["instagram_client_id"],      ENV["instagram_client_secret"], scope: 'likes comments relationships'
  provider :facebook,      ENV["facebook_app_id"],          ENV["facebook_app_secret"],
       scope: 'email, 
               user_photos, 
               user_status, 
               user_tagged_places, 
               user_videos,
               user_posts'
  provider :vimeo,         ENV["vimeo_client_id"],          ENV["vimeo_client_secret"]
  provider :flickr,        ENV["flickr_key"],                ENV["flickr_secret"],
        scope: 'read'
  provider :tumblr,        ENV["tumblr_consumer_key"],      ENV["tumblr_consumer_secret"]
  # provider :pinterest,     ENV["pinterest_client_secret"], ENV["pinterest_id"]
  provider :gplus,         ENV["google_client_id"],         ENV["google_client_secret"],
        scope: "plus.me,
                plus.stream.read"
  provider :google_oauth2, ENV["google_client_id"],         ENV["google_client_secret"],
    {
      :provider_ignores_state => true,
      :scope => "userinfo.email, 
      userinfo.profile, plus.me, 
      http://gdata.youtube.com, 
      https://www.googleapis.com/auth/plus.me",
      :prompt => "consent",
      :image_aspect_ratio => "square",
      :image_size => 50
    }



  #provider :google_plus, '585499897487-r33qnsfp30oc9tijcblj1qcvutqjks9a.apps.googleusercontent.com', 'o7gaMa7Be0uGZzAZ7z-qx73L'
  end
