Rails.application.routes.draw do
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
      get :following, :followers, :bio, :feed, :settings, :explore, :explore_users, :nfuse_page
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
  resources :activities

  # Authentication and Settings
  get    '/signup',       to: 'users#new'
  get    '/login',        to: 'sessions#new', as: :signin
  get    '/signout',      to: 'sessions#destroy'
  get    '/settings',     to: 'users#settings'
  get    '/destroytoken', to: 'users#destroytoken'
  get    '/destroyuser',  to: 'users#destroyuser'
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
  get "searchuser" => "searches#index"
  get '/search', to: 'searches#searchcontent'

  #  OmniAuth * Registrations
  scope '/auth' do
    get '/instagram/callback',     to: 'registrations/instagram#create'
    get '/twitter/callback',       to: 'registrations/twitter#create'
    get '/failure',                to: 'registrations/twitter#failure'
    get '/facebook/callback',      to: 'registrations/facebook#create'
    get '/google_oauth2/callback', to: 'registrations/youtube#create'
    get '/gplus/callback',         to: 'registrations/gplus#create'
    get '/vimeo/callback',         to: 'registrations/vimeo#create'
    # get '/pinterest/callback',     to: 'registrations/pinterest#create'
    get '/flickr/callback',        to: 'registrations/flickr#create'
    get '/tumblr/callback',        to: 'registrations/tumblr#create'
  end

  # Likes
  post '/twitter/favorite/:tweet_id', to: 'likes#twitter'
  post '/twitter/retweet/:tweet_id',  to: 'shares#twitter'
  post '/instagram/like/:media_id',   to: 'likes#instagram'
  post '/facebook/like/:post_id',     to: 'likes#facebook'

  root to: 'pages#home'

  #COMPANIES
  get '/businessconnector', to: 'pages#business_connector'
  get '/wired', to: 'pages#wired'
  get '/nationalgeographic', to: 'pages#national_geographic'
  get '/peoplemagazine', to: 'pages#people_magazine'
  get '/timemagazine', to: 'pages#time_magazine'
  get '/sportsillustrated', to: 'pages#sports_illustrated'
  get '/cosmopolitan', to: 'pages#cosmopolitan'
  get '/redbull', to: 'pages#redbull'
  get '/espn', to: 'pages#espn'
  get '/usweekly', to: 'pages#us_weekly'
  get '/entertainmentweekly', to: 'pages#entertainment_weekly'
  get '/newsweek', to: 'pages#newsweek'
  get '/popularscience', to: 'pages#popular_science'
  get '/vogue', to: 'pages#vogue'
  get '/bloomberg', to: 'pages#bloomberg_businessweekly'
  get '/gq', to: 'pages#gq'
  get '/hgtv', to: 'pages#hgtv'
  get '/forbes', to: 'pages#forbes_magazine'
  get '/fortune', to: 'pages#fortune'
  get '/enews', to: 'pages#e_news'
  get '/google', to: 'pages#google'
  get '/tedtalks', to: 'pages#tedtalks'
  get '/tesla', to: 'pages#tesla'
  get '/victoriassecret', to: 'pages#victorias_secret'
  get '/cnn', to: 'pages#cnn'
  get '/hbo', to: 'pages#hbo'
  get '/showtime', to: 'pages#showtime'
  get '/marvel', to: 'pages#marvel'
  get '/syfy', to: 'pages#syfy'
  get '/netflix', to: 'pages#netflix'
  get '/buzzfeed', to: 'pages#buzzfeed'
  get '/reddit', to: 'pages#reddit'
  get '/collegehumor', to: 'pages#collegehumor'
  get '/microsoft', to: 'pages#microsoft'
  get '/nike', to: 'pages#nike'
  get '/imdb', to: 'pages#imdb'
  get '/vevo', to: 'pages#vevo'
  get '/starwars', to: 'pages#starwars'
  get '/nasa', to: 'pages#nasa'
  get '/bravo', to: 'pages#bravo'
  get '/mtv', to: 'pages#mtv'
  get '/golfdigest', to: 'pages#golfdigest'
  get '/nba', to: 'pages#nba'
  get '/nfl', to: 'pages#nfl'
  get '/mlb', to: 'pages#mlb'
  get '/nhl', to: 'pages#nhl'
  get '/inc', to: 'pages#inc'
  get '/makerbot', to: 'pages#makerbot'
  get '/olympics', to: 'pages#olympics'
  get '/tmz', to: 'pages#tmz'
  get '/tiffany', to: 'pages#tiffany'
  get '/playboy', to: 'pages#playboy'
  get '/maxim', to: 'pages#maxim'
  get '/elle', to: 'pages#elle'
  get '/vanityfair', to: 'pages#vanityfair'
  get '/brides', to: 'pages#brides'
  get '/usatoday', to: 'pages#usatoday'
  get '/sciencechannel', to: 'pages#sciencechannel'
  get '/fifa', to: 'pages#fifa'
  get '/gucci', to: 'pages#gucci'
  get '/handm', to: 'pages#handm'
  get '/generalelectric', to: 'pages#generalelectric'
  get '/armani', to: 'pages#armani'
  get '/ibm', to: 'pages#ibm'
  get '/foxsports', to: 'pages#foxsports'
  get '/cnbc', to: 'pages#cnbc'
  get '/amazon', to: 'pages#amazon'
  get '/foodnetwork', to: 'pages#food'
  get '/sony', to: 'pages#sony'
  get '/gap', to: 'pages#gap'
  get '/history', to: 'pages#history'
  get '/ralphlauren', to: 'pages#ralph'
  get '/tlc', to: 'pages#tlc'
  get '/xbox', to: 'pages#xbox'
  get '/playstation', to: 'pages#playstation'
  get '/nordstrom', to: 'pages#nordstrom'
  get '/entrepreneur', to: 'pages#entrepreneur'
  get '/bananarepublic', to: 'pages#bananarepublic'
  get '/calvinklein', to: 'pages#calvinklein'
  get '/underarmour', to: 'pages#underarmour'
  get '/facebook', to: 'pages#facebook'
  get '/burberry', to: 'pages#burberry'
  get '/abc', to: 'pages#abc'
  get '/nbc', to: 'pages#nbc'
  get '/cbs', to: 'pages#cbs'
  get '/thecw', to: 'pages#thecw'
  get '/hugoboss', to: 'pages#hugoboss'
  get '/cbsnews', to: 'pages#cbsnews'
  get '/foxnews', to: 'pages#foxnews'
  get '/nbcnews', to: 'pages#nbcnews'
  get '/abcnews', to: 'pages#abcnews'
  get '/cbssports', to: 'pages#cbssports'
  get '/fox', to: 'pages#fox'
  get '/uber', to: 'pages#uber'
  get '/forever21', to: 'pages#forever21'
  get '/mls', to: 'pages#mls'
  get '/urbanoutfitters', to: 'pages#urbanoutfitters'
  get '/allure', to: 'pages#allure'
  get '/wmagazine', to: 'pages#wmagazine'
  get '/thescene', to: 'pages#thescene'
  get '/youtube', to: 'pages#youtube'

  #CELEBRITIES
  get'/celebrities', to: 'pages#celebrity_connector'
  get'/katyperry', to: 'pages#katyperry'
  get'/barackobama', to: 'pages#barackobama'
  get'/taylorswift', to: 'pages#taylorswift'
  get'/ladygaga', to: 'pages#ladygaga'
  get'/justintimberlake', to: 'pages#justintimberlake'
  get'/britneyspears', to: 'pages#britneyspears'
  get'/kimkardashianwest', to: 'pages#kimkardashianwest'
  get'/shakira', to: 'pages#shakira'
  get'/jenniferlopez', to: 'pages#jenniferlopez'
  get'/selenagomez', to: 'pages#selenagomez'
  get'/arianagrande', to: 'pages#arianagrande'
  get'/demilovato', to: 'pages#demilovato'
  get'/jimmyfallon', to: 'pages#jimmyfallon'
  get'/lebronjames', to: 'pages#lebronjames'
  get'/adele', to: 'pages#adele'
  get'/brunomars', to: 'pages#brunomars'
  get'/aliciakeys', to: 'pages#aliciakeys'
  get'/mileyraycyrus', to: 'pages#mileyraycyrus'
  get'/nickiminaj', to: 'pages#nickiminaj'
  get'/emmawatson', to: 'pages#emmawatson'
  get'/neilpatrickharris', to: 'pages#neilpatrickharris'
  get'/davidguetta', to: 'pages#davidguetta'
  get'/conanobrien', to: 'pages#conanobrien'
  get'/khloekardashian', to: 'pages#khloekardashian'
  get'/kourtneykardashian', to: 'pages#kourtneykardashian'
  get'/christinaaguilera', to: 'pages#christinaaguilera'
  get'/beyonce', to: 'pages#beyonce'
  get'/oprahwinfrey', to: 'pages#oprahwinfrey'
  get'/johnnydepp', to: 'pages#johnnydepp'
  get'/scarlettjohansson', to: 'pages#scarlettjohansson'
  get'/madonna', to: 'pages#madonna'
  get'/tomhanks', to: 'pages#tomhanks'
  get'/jessicaalba', to: 'pages#jessicaalba'
  get'/meganfox', to: 'pages#meganfox'
  get'/tigerwoods', to: 'pages#tigerwoods'
  get'/blakelively', to: 'pages#blakelively'
  get'/leonardodicaprio', to: 'pages#leonardodicaprio'
  get'/emmastone', to: 'pages#emmastone'
  get'/jayz', to: 'pages#jayz'
  get'/ellendegeneres', to: 'pages#ellendegeneres'
  get'/sandrabullock', to: 'pages#sandrabullock'
  get'/ashleygreene', to: 'pages#ashleygreene'
  get'/natalieportman', to: 'pages#natalieportman'
  get'/jenniferlawrence', to: 'pages#jenniferlawrence'
  get'/katebosworth', to: 'pages#katebosworth'
  get'/camerondiaz', to: 'pages#camerondiaz'
  get'/milakunis', to: 'pages#milakunis'
  get'/floydmayweather', to: 'pages#floydmayweather'
  get'/reesewitherspoon', to: 'pages#reesewitherspoon'
  get'/kateupton', to: 'pages#kateupton'
  get'/peterdinklage', to: 'pages#peterdinklage'

  #TVSHOWS
  get 'tv_shows', to: 'pages#tv_show_connector'
  get 'lastweektonight', to: 'pages#lastweektonight'
  get 'gameofthrones', to: 'pages#gameofthrones'
  get 'bettercallsaul', to: 'pages#bettercallsaul'
  get 'orangeisthenewblack', to: 'pages#orangeisthenewblack'
  get 'empire', to: 'pages#empire'
  get 'howimetyourmother', to: 'pages#howimetyourmother'
  get 'madmen', to: 'pages#madmen'
  get 'theamericans', to: 'pages#theamericans'
  get 'thetonightshow', to: 'pages#thetonightshow'
  get 'truedetective', to: 'pages#truedetective'
  get 'justified', to: 'pages#justified'
  get 'sense8', to: 'pages#sense8'
  get 'izombie', to: 'pages#izombie'
  get 'theflash', to: 'pages#theflash'
  get 'thebachelor', to: 'pages#thebachelor'
  get 'suits', to: 'pages#suits'
  get 'theellenshow', to: 'pages#theellenshow'
  get 'greysanatomy', to: 'pages#greysanatomy'
  get 'thewalkingdead', to: 'pages#thewalkingdead'
  get 'americanhorrorstory', to: 'pages#americanhorrorstory'
  get 'sharktank', to: 'pages#sharktank'
  get 'gotham', to: 'pages#gotham'
  get 'thegoodwife', to: 'pages#thegoodwife'
  get 'thebigbangtheory', to: 'pages#thebigbangtheory'
  get 'theblacklist', to: 'pages#theblacklist'
  get 'howtogetawaywithmurder', to: 'pages#howtogetawaywithmurder'
  get 'thevoice', to: 'pages#thevoice'
  get 'bachelorette', to: 'pages#bachelorette'
  get 'scandal', to: 'pages#scandal'
  get 'downtonabbey', to: 'pages#downtonabbey'
  get 'dancingwiththestars', to: 'pages#dancingwiththestars'
  get 'americanidol', to: 'pages#americanidol'
  get 'thementalist', to: 'pages#thementalist'
  get 'houseofcards', to: 'pages#houseofcards'
  get 'transparent', to: 'pages#transparent'
  get 'louie', to: 'pages#louie'
  get 'community', to: 'pages#community'
  get 'parksandrecreation', to: 'pages#parksandrecreation'
  get 'sonsofanarchy', to: 'pages#sonsofanarchy'
  get 'brooklynninenine', to: 'pages#brooklynninenine'
  get 'janethevirgin', to: 'pages#janethevirgin'
  get 'fargo', to: 'pages#fargo'
  get 'saturdaynightlive', to: 'pages#saturdaynightlive'
  get 'mrrobot', to: 'pages#mrrobot'
  get 'newgirl', to: 'pages#newgirl'
  get 'scorpion', to: 'pages#scorpion'
  get 'modernfamily', to: 'pages#modernfamily'
  get 'themindyproject', to: 'pages#themindyproject'

  ######## SPORTS
  get 'sports', to: 'pages#sports_connector'
  get 'realmadrid', to: 'pages#realmadrid'
  get 'dallascowboys', to: 'pages#dallascowboys'
  get 'newyorkyankees', to: 'pages#newyorkyankees'
  get 'barcelona', to: 'pages#barcelona'
  get 'manchesterunited', to: 'pages#manchesterunited'
  get 'losangeleslakers', to: 'pages#losangeleslakers'
  get 'newenglandpatriots', to: 'pages#newenglandpatriots'
  get 'newyorkknicks', to: 'pages#newyorkknicks'
  get 'losangelesdodgers', to: 'pages#losangelesdodgers'
  get 'washingtonredskins', to: 'pages#washingtonredskins'
  get 'bayernmunich', to: 'pages#bayernmunich'
  get 'bostonredsox', to: 'pages#bostonredsox'
  get 'newyorkgiants', to: 'pages#newyorkgiants'
  get 'chicagobulls', to: 'pages#chicagobulls'
  get 'sanfranciscogiants', to: 'pages#sanfranciscogiants'
  get 'houstontexans', to: 'pages#houstontexans'
  get 'chicagocubs', to: 'pages#chicagocubs'
  get 'newyorkjets', to: 'pages#newyorkjets'
  get 'philadelphiaeagles', to: 'pages#philadelphiaeagles'
  get 'bostonceltics', to: 'pages#bostonceltics'
  get 'chicagobears', to: 'pages#chicagobears'
  get 'losangelesclippers', to: 'pages#losangelesclippers'
  get 'sanfrancisco49ers', to: 'pages#sanfrancisco49ers'
  get 'baltimoreravens', to: 'pages#baltimoreravens'
  get 'brooklynnets', to: 'pages#brooklynnets'
  get 'denverbroncos', to: 'pages#denverbroncos'
  get 'indianapoliscolts', to: 'pages#indianapoliscolts'
  get 'stlouiscardinals', to: 'pages#stlouiscardinals'
  get 'greenbaypackers', to: 'pages#greenbaypackers'
  get 'manchestercity', to: 'pages#manchestercity'
  get 'chelsea', to: 'pages#chelsea'
  get 'ferrari', to: 'pages#ferrari'
  get 'newyorkmets', to: 'pages#newyorkmets'
  get 'pittsburghsteelers', to: 'pages#pittsburghsteelers'
  get 'seattleseahawks', to: 'pages#seattleseahawks'
  get 'arsenal', to: 'pages#arsenal'
  get 'goldenstatewarriors', to: 'pages#goldenstatewarriors'
  get 'losangelesangelsofanaheim', to: 'pages#losangelesangelsofanaheim'
  get 'miamidolphins', to: 'pages#miamidolphins'
  get 'torontomapleleafs', to: 'pages#torontomapleleafs'
  get 'washingtonnationals', to: 'pages#washingtonnationals'
  get 'carolinapanthers', to: 'pages#carolinapanthers'
  get 'houstonrockets', to: 'pages#houstonrockets'
  get 'philadelphiaphillies', to: 'pages#philadelphiaphillies'
  get 'tampabaybuccaneers', to: 'pages#tampabaybuccaneers'
  get 'texasrangers', to: 'pages#texasrangers'
  get 'miamiheat', to: 'pages#miamiheat'
  get 'tennesseetitans', to: 'pages#tennesseetitans'
  get 'atlantabraves', to: 'pages#atlantabraves'
  get 'minnesotavikings', to: 'pages#minnesotavikings'
  get 'arizonacardinals', to: 'pages#arizonacardinals'

  ######MUSIC
  get 'music', to: 'pages#music_connector'
  get 'onedirection', to: 'pages#onedirection'
  get 'katyperrymusic', to: 'pages#katyperrymusic'
  get 'beyoncemusic', to: 'pages#beyoncemusic'
  get 'taylorswiftmusic', to: 'pages#taylorswiftmusic'
  get 'justintimberlakemusic', to: 'pages#justintimberlakemusic'
  get 'iggyazalea', to: 'pages#iggyazalea'
  get 'arianagrandemusic', to: 'pages#arianagrandemusic'
  get 'mileycyrus', to: 'pages#mileycyrus'
  get 'pharrelwilliams', to: 'pages#pharrelwilliams'
  get 'eminem', to: 'pages#eminem'
  get 'lorde', to: 'pages#lorde'
  get 'lukebryan', to: 'pages#lukebryan'
  get 'samsmith', to: 'pages#samsmith'
  get 'johnlegend', to: 'pages#johnlegend'
  get 'onerepublic', to: 'pages#onerepublic'
  get 'drake', to: 'pages#drake'
  get 'jasonderulo', to: 'pages#jasonderulo'
  get 'justinbieber', to: 'pages#justinbieber'
  get 'imaginedragons', to: 'pages#imaginedragons'
  get 'floridageorgialine', to: 'pages#floridageorgialine'
  get 'nickiminajmusic', to: 'pages#nickiminajmusic'
  get 'secondsofsummer', to: 'pages#secondsofsummer'
  get 'ladygagamusic', to: 'pages#ladygagamusic'
  get 'pitbull', to: 'pages#pitbull'
  get 'brunomarsmusic', to: 'pages#brunomarsmusic'
  get 'jasonaldean', to: 'pages#jasonaldean'
  get 'maroon5', to: 'pages#maroon5'
  get 'chrisbrown', to: 'pages#chrisbrown'
  get 'meghantrainor', to: 'pages#meghantrainor'
  get 'bastille', to: 'pages#bastille'
  get 'avicii', to: 'pages#avicii'
  get 'magic', to: 'pages#magic'
  get 'demilovatomusic', to: 'pages#demilovatomusic'
  get 'blakeshelton', to: 'pages#blakeshelton'
  get 'coldplay', to: 'pages#coldplay'
  get 'charlixcx', to: 'pages#charlixcx'
  get 'nicoandvinz', to: 'pages#nicoandvinz'
  get 'therollingstones', to: 'pages#therollingstones'
  get 'shakiramusic', to: 'pages#shakiramusic'
  get 'passenger', to: 'pages#passenger'
  get 'brantleygilbert', to: 'pages#brantleygilbert'
  get 'elliegoulding', to: 'pages#elliegoulding'
  get 'ericchurch', to: 'pages#ericchurch'
  get 'idinamenzel', to: 'pages#idinamenzel'
  get 'selenagomezmusic', to: 'pages#selenagomezmusic'
  get 'calvinharris', to: 'pages#calvinharris'
  get 'michaelbuble', to: 'pages#michaelbuble'
  get 'michaeljackson', to: 'pages#michaeljackson'
  get 'britneyspearsmusic', to: 'pages#britneyspearsmusic'
  get 'kellyclarkson', to: 'pages#kellyclarkson'
  get 'christinaaguileramusic', to: 'pages#christinaaguileramusic'

  ####FOOD
  get 'food', to: 'pages#food_connector'
  get 'allrecipes', to: 'pages#allrecipes'
  get 'cookingdotcom', to: 'pages#cookingdotcom'
  get 'foodnetworkchannel', to: 'pages#foodnetwork'
  get 'thekitchn', to: 'pages#thekitchn'
  get 'opentable', to: 'pages#opentable'
  get 'tasteofhome', to: 'pages#tasteofhome'
  get 'epicurious', to: 'pages#epicurious'
  get 'grubhub', to: 'pages#grubhub'
  get 'seamless', to: 'pages#seamless'
  get 'yummly', to: 'pages#yummly'
  get 'huffingtonpostfood', to: 'pages#huffingtonpostfood'
  get 'fooddotcom', to: 'pages#fooddotcom'
  get 'bonappetit', to: 'pages#bonappetit'
  get 'weightwatchers', to: 'pages#weightwatchers'
  get 'foodandwine', to: 'pages#foodandwine'
  get 'thechew', to: 'pages#thechew'
  get 'americastestkitchen', to: 'pages#americastestkitchen'
  get 'ironchefamerica', to: 'pages#ironchefamerica'

end
 # http://stackoverflow.com/questions/25415123/is-there-something-wrong-with-my-current-user/25416296#25416296

