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
    resources :comments
    member do
      get :following, :followers, :bio, :feed, :settings, :explore
    end
  end

  resources :shouts do
    resources :comments
    member do
      put "like", to: "shouts#like"
      put "dislike", to: "shouts#dislike"
    end
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
  
  # Static pages
  get '/help',     to: 'pages#help'
  get '/about',    to: 'pages#about'
  get '/feedback', to: 'pages#feedback'
  get '/terms',    to: 'pages#terms'
  get '/privacy',  to: 'pages#privacy'
  get '/qanda',    to: 'pages#qanda'

  get '/contacts', to: 'contacts#new'

  get '/feed_content', to: 'users#feed', as: :feed_content
  get "search" => "searches#index"

  get '/auth/instagram/callback', to: 'instagram_registration#create'
  get '/auth/twitter/callback', to: 'twitter_registration#create'
  get '/auth/failure', to: 'twitter_registration#failure'
  get '/auth/facebook/callback', to: 'facebook_registration#create'
  get '/oauth2/callback', to: 'youtube_registration#create'

  post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  post '/twitter/retweet/:tweet_id', to: 'shares#twitter'
  post '/instagram/like/:media_id', to: 'likes#instagram'
  post '/facebook/like/:post_id', to: 'likes#facebook'

  root to: 'pages#home'
end
 # http://stackoverflow.com/questions/25415123/is-there-something-wrong-with-my-current-user/25416296#25416296

