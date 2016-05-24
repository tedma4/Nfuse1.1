Rails.application.routes.draw do
#This says that the messages'resources are apart of the conversation
  # resources :conversations do
  #   resources :messages, only: [:create]
  # end

  resources :callback_links

  resources :users do
    scope module: :users do
      resource :nfused_page, only: [:create, :destroy, :show]
    end
    # post to this new controller.
    resources :nfuse_pages
    # resources :conversations
    resources :shouts
    # resources :comments do
    #   resources :comments
    # end
    member do
      get :following, :followers, :bio, :feed, 
      :settings, :explore, :explore_users, :nfuse_page, 
      :vue, :followed_pages, :followed_nfusers, :user_likes
    end
  end
  resources :comments do
    resources :comments
  end

  resources :pages, except: :index do
    resources :comments
  end
    get 'all_pages', to: 'pages#index', as: 'all_pages'
  
  get 'show_forum', to: "pages#show_forum"
  post 'nfuse_post/:id', to: 'shouts#nfuse_post', as: 'nfuse_post'

  # on line 27 of routes file replace that block with this.
  scope module: :shouts do
    # This was breaking the * routes 
    #  Any character after shout/<c> it thinks is an id.
    scope '/nfuse_shouts' do
      post "like", to: "likes#create",       as: :like_shout
      delete "dislike", to: "likes#destroy", as: :dislike_shout
    end
  end
  scope module: :comments do

    post "like", to: "like_comments#create",       as: :like_this_comment
    delete "dislike", to: "like_comments#destroy", as: :dislike_this_comment
  end

  get 'individual_post', to: 'pages#individual_post'

  resources :shouts do
    resources :comments
  end

  resources :nfuse_pages do
    resources :shouts
  end

  scope '/comments' do
    post '/twitter/:twitter_post_id',     to: 'comments#create'
    post '/instagram/:instagram_post_id', to: 'comments#create'
    post '/facebook/:facebook_post_id',   to: 'comments#create'
    post '/youtube/:youtube_post_id',     to: 'comments#create'
    post '/gplus/:gplus_post_id',         to: 'comments#create'
    post '/vimeo/:vimeo_post_id',         to: 'comments#create'
    post '/pinterest/:pinterest_post_id',       to: 'comments#create'
    post '/tumblr/:tumblr_post_id',       to: 'comments#create'

    # Add others follow convention

  end

  # resources :events do
  #   resources :comments
  #   member do
  #     put "like",    to: "events#like"
  #     put "dislike", to: "events#dislike"
  #   end
  # end
  
  resources :contacts, path: 'contact_us', only: [:create]
  get 'contact_us', to: 'contacts#new'
  resources :sessions,                  only: [:new, :create, :destroy]
  resources :relationships,             only: [:create, :destroy]
  resources :password_resets
  get 'password_reset', to: 'password_resets#new'
  resources :activities, path: 'notifications'
  get 'activities/individual_activity'
  # Authentication and Settings
  get '/signup',       to: 'users#new'
  get '/login',        to: 'sessions#new', as: :signin
  # get '/auth/facebook/callback' , to: 'sessions#fb_callback', as: :fb_signup
  get '/signout',      to: 'sessions#destroy'
  get '/settings',     to: 'users#settings'
  get '/destroytoken', to: 'users#destroytoken'
  get '/destroyuser',  to: 'users#destroyuser'
  get '/remove_token',  to: 'users#remove_token'
  #get    '/nfuse_page', to: 'users#nfuse_page'
  
  # New Hub and hub all pages

  get '/hub/hq/nfusers',     to: 'pages#nfuse_user_posts'
  get '/hub/hq/pages',       to: 'pages#nfuse_page_posts'
  get '/hub/hq/nfuse',       to: 'pages#nfuse_posts'
  get '/hub/hq/twitternews', to: 'pages#nfuse_trending_twitter_posts'
  get '/hub/hq/youtube',     to: 'pages#nfuse_page_posts'

  # Static pages
  get '/help',              to: 'pages#help'
  # get '/about',             to: 'pages#about'
  get '/privacy',           to: 'pages#privacy'
  get '/preview',           to: 'shouts#preview'

  get '/contacts', to: 'contacts#new'

  get '/feed_content', to: 'users#feed_content', as: :feed_content
  get '/search', to: 'searches#searchcontent'
  get '/random_search', to: 'searches#random_search'

  #  OmniAuth * Registrations
  # if user.id.present?
   scope '/auth' do
     get '/instagram/callback',     to: 'registrations/instagram#create'
     get '/twitter/callback',       to: 'registrations/twitter#create'
     get '/failure',                to: 'registrations/twitter#failure'
     get '/facebook/callback',      to: 'registrations/facebook#create'
     get '/google_oauth2/callback', to: 'registrations/youtube#create'
     get '/gplus/callback',         to: 'registrations/gplus#create'
     get '/vimeo/callback',         to: 'registrations/vimeo#create'
     get '/pinterest/callback',     to: 'registrations/pinterest#create'
     get '/tumblr/callback',        to: 'registrations/tumblr#create'
   end
  # else
  #   get 'auth/:provider/callback', to: 'sessions#create'
  # end
  # Likes
  # post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  # post '/twitter/retweet/:tweet_id',  to: 'shares#twitter'
  # post '/instagram/like/:media_id',   to: 'likes#instagram'
  # post '/facebook/like/:post_id',     to: 'likes#facebook'

  root to: 'pages#home'

  #COMPANIES
  get'/my_top_50', to: 'pages#mytop50'
  get'/most_popular', to: 'pages#mostpopular'
  get'/random', to: 'pages#random'
  get'/trending', to: 'pages#trending'
  get '/businessconnector', to: 'pages#business_connector'

  #CELEBRITIES
  get'/celebrities', to: 'pages#celebrity_connector'
  #TVSHOWS
  get 'tv_shows', to: 'pages#tv_show_connector'
  ######## SPORTS
  get 'sports', to: 'pages#sports_connector'
  ######MUSIC
  get 'music', to: 'pages#music_connector'
  ####FOOD
  get 'food', to: 'pages#food_connector'
  #####TRAVEL
  get 'travel', to: 'pages#travel_connector'
  #####FASHION
  get 'fashion', to: 'pages#fashion_connector'
  #####YOUTUBERS
  get 'youtubers', to: 'pages#youtubers'

  #####YOUTUBERS
  get 'news', to: 'pages#news_connector'
  #####YOUTUBERS
  get 'fitness', to: 'pages#fitness_connector'
  #####YOUTUBERS
  get 'nerdish', to: 'pages#nerdish_connector'
  #####YOUTUBERS
  get 'shopping', to: 'pages#shopping_connector'
  #####YOUTUBERS
  get 'wedding', to: 'pages#wedding_connector'
  #####YOUTUBERS
  get 'animals', to: 'pages#animals_connector'
  #####YOUTUBERS
  get 'instagramers', to: 'pages#instagramers_connector'
end
 # http://stackoverflow.com/questions/25415123/is-there-something-wrong-with-my-current-user/25416296#25416296

