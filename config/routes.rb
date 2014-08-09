Rails.application.routes.draw do
  resources :users do
    member do
      get :following, :followers, :bio, :feed
    end
  end
  resources :contacts, only: [:new, :create]
  resources :sessions,      only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  root to: 'pages#home'
  match '/signup',   to: 'users#new',            via: 'get'
  match '/signin',   to: 'sessions#new',         via: 'get'
  match '/signout',  to: 'sessions#destroy',     via: 'delete'
  match '/help',     to: 'pages#help',           via: 'get'
  match '/about',    to: 'pages#about',          via: 'get'
  match '/feedback', to: 'pages#feedback',       via: 'get'
  match '/terms',    to: 'pages#terms',          via: 'get'
  match '/qanda',    to: 'pages#qanda',          via: 'get'
  match '/contacts', to: 'contacts#new',         via: 'get'

  get '/feed', to: 'feed#index', as: :feed
  get '/feed_content', to: 'feed#feed', as: :feed_content
  get '/auth/instagram/callback', to: 'instagram_registration#create'
  get '/auth/twitter/callback', to: 'twitter_registration#create'
  get '/auth/facebook/callback', to: 'facebook_registration#create'
  get '/auth/failure', to: 'twitter_registration#failure'

  resources :posts

  post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  post '/twitter/retweet/:tweet_id', to: 'shares#twitter'
  post '/instagram/like/:media_id', to: 'likes#instagram'
  post '/facebook/like/:post_id', to: 'likes#facebook'

end
