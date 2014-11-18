Rails.application.routes.draw do

  ActiveAdmin.routes(self)
#This says that the messages'resources are apart of the conversation
  resources :conversations do
    resources :messages, only: [:create]
  end

  resources :callback_links

  resources :users do
    resources :conversations
    resources :shouts
    member do
      get :following, :followers, :bio, :feed, :settings, :hub, :explore
    end
  end

  resources :identities
  resources :shouts do
    resources :comments
    member do
      put "like", to: "shouts#like"
      put "dislike", to: "shouts#dislike"
    end
  end
  
  resources :contacts, only: [:new, :create]
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :password_resets
  root to: 'pages#home'
  match '/signup',   to: 'users#new',       via: 'get'
  match '/signin',   to: 'sessions#new',         via: 'get'
  match '/signout',  to: 'sessions#destroy',     via: 'delete'
  match '/help',     to: 'pages#help',           via: 'get'
  match '/about',    to: 'pages#about',          via: 'get'
  match '/feedback', to: 'pages#feedback',       via: 'get'
  match '/terms',    to: 'pages#terms',          via: 'get'
  match '/privacy',  to: 'pages#privacy',        via: 'get'
  match '/qanda',    to: 'pages#qanda',          via: 'get'
  match '/contacts', to: 'contacts#new',         via: 'get'
  match '/settings', to: 'users#settings',       via: 'get'
   get '/feed_content', to: 'users#feed', as: :feed_content
   get "search" => "searches#index"
  
  get '/auth/instagram/callback', to: 'instagram_registration#create'
  get '/auth/twitter/callback', to: 'twitter_registration#create'
  get '/auth/facebook/callback', to: 'facebook_registration#create'
  get '/auth/failure', to: 'twitter_registration#failure'

  post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  post '/twitter/retweet/:tweet_id', to: 'shares#twitter'
  post '/instagram/like/:media_id', to: 'likes#instagram'
  post '/facebook/like/:post_id', to: 'likes#facebook'

  match "/auth/identity/callback", to: "sessions#create", via: 'post'
  match "/auth/failure", to: "sessions#failure",  via: 'get'

end
 # http://stackoverflow.com/questions/25415123/is-there-something-wrong-with-my-current-user/25416296#25416296

