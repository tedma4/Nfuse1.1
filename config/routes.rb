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
      get :following, :followers, :bio, :feed, :settings, :explore, :nfuse_page, :nfuse_only, :twitter_only, :instagram_only, :facebook_only, :explore_nfuse_only, :explore_twitter_only, :explore_instagram_only, :explore_facebook_only
    end
  end

  post 'nfuse_post/:id', to: 'shouts#nfuse_post', as: 'nfuse_post'

  scope module: :shouts do
    scope '/shouts' do
      post "like", to: "likes#create", as: :like_shout
      delete "dislike", to: "likes#destroy", as: :dislike_shout
    end
  end

  resources :shouts do
    resources :comments
  end

  resources :nfuse_pages do
    resources :shouts
  end

  resources :events do
    resources :comments
    member do
      put "like", to: "events#like"
      put "dislike", to: "events#dislike"
    end
  end
  
  resources :contacts, only: [:new, :create]
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :password_resets

  # Authentication and Settings
  get    '/signup',   to: 'users#new'
  get    '/signin',   to: 'sessions#new'
  delete '/signout',  to: 'sessions#destroy'
  get    '/settings', to: 'users#settings'
  #get    '/nfuse_page', to: 'users#nfuse_page'
  
  # Static pages
  get '/help',     to: 'pages#help'
  get '/about',    to: 'pages#about'
  get '/feedback', to: 'pages#feedback'
  get '/terms',    to: 'pages#terms'
  get '/privacy',  to: 'pages#privacy'
  get '/qanda',    to: 'pages#qanda'
  get '/preview',  to: 'shouts#preview'

  get '/contacts', to: 'contacts#new'

  get '/feed_content', to: 'users#feed', as: :feed_content
  get "search" => "searches#index"

  #  OmniAuth * Registrations
  scope '/auth' do
    get '/instagram/callback',     to: 'registrations/instagram#create'
    get '/twitter/callback',       to: 'registrations/twitter#create'
    get '/failure',                to: 'registrations/twitter#failure'
    get '/facebook/callback',      to: 'registrations/facebook#create'
    get '/google_oauth2/callback', to: 'registrations/youtube#create'
    get '/vimeo/callback',         to: 'registrations/vimeo#create'
  end

  # Likes
  post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  post '/twitter/retweet/:tweet_id',  to: 'shares#twitter'
  post '/instagram/like/:media_id',   to: 'likes#instagram'
  post '/facebook/like/:post_id',     to: 'likes#facebook'

  root to: 'pages#home'
end
 # http://stackoverflow.com/questions/25415123/is-there-something-wrong-with-my-current-user/25416296#25416296

