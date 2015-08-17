# names not mapped directly to actions - "have an underscore."
CO_LIST={
  'nationalgeographic' => 'national_geographic',
  'peoplemagazine' => 'people_magazine',
  'timemagazine'  => 'time_magazine',
  'sportsillustrated' => 'sports_illustrated',
  'usweekly'  => 'us_weekly',
  'entertainmentweekly' => 'entertainment_weekly',
  'popularscience'  => 'popular_science',
  'bloomberg' => 'bloomberg_businessweekly',
  'forbes'  => 'forbes_magazine',
  'enews'   => 'e_news',
  'victoriassecret' => 'victorias_secret',
  'businessconnector' => 'business_connector'
}

class CompanyPage
  def call(env)
        # Matches the route to action based on '/:company' 
        # 1. You may want to name all the actions exactly the same as the routes.
        company = env['action_dispatch.request.path_parameters'][:company]
        # Either in HASH or return original name.
        company = CO_LIST.fetch(company, company)
        # Compute these the way you like, possibly using view_name
        controller_class=  PagesController
        controller_class.action( company.to_sym ).call(env)
  end
end


  # get '/wired', to: 'pages#wired'
  # get '/nationalgeographic', to: 'pages#national_geographic'
  # get '/peoplemagazine', to: 'pages#people_magazine'
  # get '/timemagazine', to: 'pages#time_magazine'
  # get '/sportsillustrated', to: 'pages#sports_illustrated'
  # get '/cosmopolitan', to: 'pages#cosmopolitan'
  # get '/redbull', to: 'pages#redbull'
  # get '/espn', to: 'pages#espn'
  # get '/usweekly', to: 'pages#us_weekly'
  # get '/entertainmentweekly', to: 'pages#entertainment_weekly'
  # get '/newsweek', to: 'pages#newsweek'
  # get '/popularscience', to: 'pages#popular_science'
  # get '/vogue', to: 'pages#vogue'
  # get '/bloomberg', to: 'pages#bloomberg_businessweekly'
  # get '/gq', to: 'pages#gq'
  # get '/hgtv', to: 'pages#hgtv'
  # get '/forbes', to: 'pages#forbes_magazine'
  # get '/fortune', to: 'pages#fortune'
  # get '/enews', to: 'pages#e_news'
  # get '/google', to: 'pages#google'
  # get '/tedtalks', to: 'pages#tedtalks'
  # get '/tesla', to: 'pages#tesla'
  # get '/victoriassecret', to: 'pages#victorias_secret'
  # get '/cnn', to: 'pages#cnn'
  # get '/businessconnector', to: 'pages#business_connector'
