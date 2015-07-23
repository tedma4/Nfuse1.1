Rails.application.routes.draw do

  ActiveAdmin.routes(self)
#This says that the messages'resources are apart of the conversation
  resources :conversations do
    resources :messages, only: [:create]
  end

  resources :callback_links

  resources :users do
    scope module: :users do
      resource :nfused_page, only: [:create, :destroy, :show]
    end
    # post to this new controller.
    resources :nfuse_pages
    resources :conversations
    resources :shouts
    resources :comments
    member do
      get :following, :followers, :bio, :feed, :settings, :explore, :nfuse_page,
       :nfuse_only, :twitter_only, :instagram_only, :facebook_only, :youtube_only,
       :gplus_only, :vimeo_only, :flickr_only, :tumblr_only,
       :explore_nfuse_only, :explore_twitter_only, :explore_instagram_only,
       :explore_facebook_only, :explore_youtube_only, :explore_gplus_only,
       :explore_vimeo_only, :explore_flickr_only, :explore_tumblr_only
    end
  end

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
    post '/flickr/:flickr_post_id',       to: 'comments#create'
    post '/tumblr/:tumblr_post_id',       to: 'comments#create'

    # Add others follow convention

  end

  resources :events do
    resources :comments
    member do
      put "like",    to: "events#like"
      put "dislike", to: "events#dislike"
    end
  end
  
  resources :contacts,      only: [:new, :create]
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :password_resets

  # Authentication and Settings
  get    '/signup',   to: 'users#new'
  get    '/login',    to: 'sessions#new', as: :signin
  get '/signout',  to: 'sessions#destroy'
  get    '/settings', to: 'users#settings'
  #get    '/nfuse_page', to: 'users#nfuse_page'
  
  # Static pages
  get '/help',              to: 'pages#help'
  get '/notifications',     to: 'pages#notifications'
  get '/about',             to: 'pages#about'
  get '/feedback',          to: 'pages#feedback'
  get '/terms',             to: 'pages#terms'
  get '/privacy',           to: 'pages#privacy'
  get '/qanda',             to: 'pages#qanda'
  get '/preview',           to: 'shouts#preview'

  get '/contacts', to: 'contacts#new'

  get '/feed_content', to: 'users#feed_content', as: :feed_content
  post '/load_more',    to: 'users#load_more', as: :load_more

  get "search" => "searches#index"

  #  OmniAuth * Registrations
  scope '/auth' do
    get '/instagram/callback',     to: 'registrations/instagram#create'
    get '/twitter/callback',       to: 'registrations/twitter#create'
    get '/failure',                to: 'registrations/twitter#failure'
    get '/facebook/callback',      to: 'registrations/facebook#create'
    get '/google_oauth2/callback', to: 'registrations/youtube#create'
    get '/gplus/callback',         to: 'registrations/gplus#create'
    get '/vimeo/callback',         to: 'registrations/vimeo#create'
    get '/pinterest/callback',     to: 'registrations/pinterest#create'
    get '/flickr/callback',        to: 'registrations/flickr#create'
    get '/tumblr/callback',        to: 'registrations/tumblr#create'
  end

  # Likes
  post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  post '/twitter/retweet/:tweet_id',  to: 'shares#twitter'
  post '/instagram/like/:media_id',   to: 'likes#instagram'
  post '/facebook/like/:post_id',     to: 'likes#facebook'

  root to: 'pages#home'
end
 # http://stackoverflow.com/questions/25415123/is-there-something-wrong-with-my-current-user/25416296#25416296

