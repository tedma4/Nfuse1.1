# Twitter
# API key	n6107y4oqyomedLDZsMUytEoO
# API secret	jTndXRNGkw6eTI77TJixAxiCuD5D9eKE10GjrzL4WIDwaMquU9
# Access token	2525729819-vzV2pFCEijTs2PRrTr0P5vkmSHw1rDf9HhaPMJZ
# Access token secret	GWdCHUTzKC5s7XkERiDQrwZoeQwYVrSWCrHxiiPiIBfmP
# 
# Facebook
# App ID 713308098724920
# App Secret 1ec06851ea5b8ebfec98ac420448d7da
# 
# Instagram
# CLIENT ID	d5a97c3cf7b04c70ae234eb9933ef2fd
# CLIENT SECRET	2796ff9c9aae40ba9481d19c35f106ee

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'n6107y4oqyomedLDZsMUytEoO', 'jTndXRNGkw6eTI77TJixAxiCuD5D9eKE10GjrzL4WIDwaMquU9'
  provider :instagram, 'd5a97c3cf7b04c70ae234eb9933ef2fd', '2796ff9c9aae40ba9481d19c35f106ee', :scope => 'likes comments relationships'
  provider :facebook, '713308098724920', '1ec06851ea5b8ebfec98ac420448d7da', :scope => 'email, publish_actions, user_photos, user_status, user_tagged_places, user_videos'
  provider :identity,
    fields: [:email, :first_name, :last_name, :user_name],
  	model: User,
  	on_failed_registration: lambda { |env|
    				UsersController.action(:new).call(env)
  }
end
