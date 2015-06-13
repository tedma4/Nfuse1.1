Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,       ENV["twitter_api_key"],          ENV["twitter_api_secret"]
  provider :instagram,     ENV["instagram_client_id"],      ENV["instagram_client_secret"], scope: 'likes comments relationships'
  provider :facebook,      ENV["facebook_app_id"],          ENV["facebook_app_secret"],
       scope: 'email, 
               user_photos, 
               user_status, 
               user_tagged_places, 
               user_videos'
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
