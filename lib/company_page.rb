 # names not mapped directly to actions - "have an underscore."
 CO_LIST={
   'wired' => 'wired',
   'nationalgeographic' => 'national_geographic',
   'peoplemagazine' => 'people_magazine',
   'timemagazine' => 'time_magazine',
   'sportsillustrated' => 'sports_illustrated',
   'cosmopolitan' => 'cosmopolitan',
   'redbull' => 'redbull',
   'espn' => 'espn',
   'usweekly' => 'us_weekly',
   'entertainmentweekly' => 'entertainment_weekly',
   'newsweek' => 'newsweek',
   'popularscience' => 'popular_science',
   'vogue' => 'vogue',
   'bloomberg' => 'bloomberg_businessweekly',
   'gq' => 'gq',
   'hgtv' => 'hgtv',
   'forbes' => 'forbes_magazine',
   'fortune' => 'fortune',
   'enews' => 'e_news',
   'google' => 'google',
   'tedtalks' => 'tedtalks',
   'tesla' => 'tesla',
   'victoriassecret' => 'victorias_secret',
   'cnn' => 'cnn',
   'businessconnector' => 'business_connector',
   'hbo' => 'hbo',
   'showtime' => 'showtime',
   'marvel' => 'marvel',
   'syfy' => 'syfy',
   'netflix' => 'netflix',
   'buzzfeed' => 'buzzfeed',
   'reddit' => 'reddit',
   'collegehumor' => 'collegehumor',
   'microsoft' => 'microsoft',
   'nike' => 'nike',
   'imdb' => 'imdb',
   'vevo' => 'vevo',
   'starwars' => 'starwars',
   'nasa' => 'nasa',
   'bravo' => 'bravo',
   'mtv' => 'mtv',
   'golfdigest' => 'golfdigest',
   'nba' => 'nba',
   'nfl' => 'nfl',
   'mlb' => 'mlb',
   'nhl' => 'nhl',
   'inc' => 'inc',
   'makerbot' => 'makerbot',
   'olympics' => 'olympics',
   'tmz' => 'tmz',
   'tiffany' => 'tiffany',
   'playboy' => 'playboy',
   'maxim' => 'maxim',
   'elle' => 'elle',
   'vanityfair' => 'vanityfair',
   'brides' => 'brides',
   'usatoday' => 'usatoday',
   'sciencechannel' => 'sciencechannel',
   'fifa' => 'fifa',
   'gucci' => 'gucci',
   'handm' => 'handm',
   'generalelectric' => 'generalelectric',
   'armani' => 'armani',
   'ibm' => 'ibm',
   'foxsports' => 'foxsports',
   'cnbc' => 'cnbc',
   'amazon' => 'amazon',
   'foodnetwork' => 'food',
   'sony' => 'sony',
   'gap' => 'gap',
   'history' => 'history',
   'ralphlauren' => 'ralph',
   'tlc' => 'tlc',
   'xbox' => 'xbox',
   'playstation' => 'playstation',
   'nordstrom' => 'nordstrom',
   'entrepreneur' => 'entrepreneur',
   'bananarepublic' => 'bananarepublic',
   'calvinklein' => 'calvinklein',
   'underarmour' => 'underarmour',
   'facebook' => 'facebook',
   'burberry' => 'burberry',
   'abc' => 'abc',
   'nbc' => 'nbc',
   'cbs' => 'cbs',
   'thecw' => 'thecw',
   'hugoboss' => 'hugoboss',
   'cbsnews' => 'cbsnews',
   'foxnews' => 'foxnews',
   'nbcnews' => 'nbcnews',
   'abcnews' => 'abcnews',
   'cbssports' => 'cbssports',
   'fox' => 'fox',
   'uber' => 'uber',
   'forever21' => 'forever21',
   'mls' => 'mls',
   'urbanoutfitters' => 'urbanoutfitters',
   'allure' => 'allure',
   'wmagazine' => 'wmagazine',
   'thescene' => 'thescene',
   'youtube' => 'youtube'
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
 
 
   #  'wired' => 'wired'
   #  'nationalgeographic' => 'national_geographic'
   #  'peoplemagazine' => 'people_magazine'
   #  'timemagazine' => 'time_magazine'
   #  'sportsillustrated' => 'sports_illustrated'
   #  'cosmopolitan' => 'cosmopolitan'
   #  'redbull' => 'redbull'
   #  'espn' => 'espn'
   #  'usweekly' => 'us_weekly'
   #  'entertainmentweekly' => 'entertainment_weekly'
   #  'newsweek' => 'newsweek'
   #  'popularscience' => 'popular_science'
   #  'vogue' => 'vogue'
   #  'bloomberg' => 'bloomberg_businessweekly'
   #  'gq' => 'gq'
   #  'hgtv' => 'hgtv'
   #  'forbes' => 'forbes_magazine'
   #  'fortune' => 'fortune'
   #  'enews' => 'e_news'
   #  'google' => 'google'
   #  'tedtalks' => 'tedtalks'
   #  'tesla' => 'tesla'
   #  'victoriassecret' => 'victorias_secret'
   #  'cnn' => 'cnn'
   #  'businessconnector' => 'business_connector'


