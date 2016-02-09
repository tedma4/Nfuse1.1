class PagesController < ApplicationController
  include Poly::Commentable

  before_action :set_page, except:[:home, :help, :about, :feedback, :terms, 
                                   :privacy, :business_connector, :celebrity_connector, 
                                   :tv_show_connector, :fashion_connector, :youtubers,
                                   :sports_connector, :music_connector, :food_connector,
                                   :travel_connector, :test_page, :mytop50, :mostpopular,
                                   :random, :trending, :individual_post, :show#, :wiredtestthing
                                  ]
  # before_action :find_page, except:[:home, :help, :about, :feedback, :terms, 
  #                                  :privacy, :business_connector, :celebrity_connector, 
  #                                  :tv_show_connector, :fashion_connector, :youtubers,
  #                                  :sports_connector, :music_connector, :food_connector,
  #                                  :travel_connector, :test_page, :mytop50, :mostpopular,
  #                                  :random, :trending, :wiredtestthing
  #                                 ]
  #Blank is gonna be a reservered word for now
  def show
    @page = Page.find(params[:id])
  end
  
  def home
    if signed_in?
      @providers = Providers.for(current_user)
      # @token = []
      # if current_user.followed_users.any?
      #   current_user.followed_users.each do |i|
      #     @token << i.tokens.pluck(:provider, :uid, :access_token, :access_token_secret, :refresh_token)
      #   end
      #   unless @token.empty?
      #     @token = @token[0]
      #   else
      #     @token
      #   end
      # else
      #   @token
      # end
      timeline = []
      ids =  current_user.relationships.where(follow_type: 'User').collect(&:id)
      unless ids.empty?
        @users = User.where(id: ids)
        @users.find_each do |user|
          feed=Networks::Timeline.new(user)
          timeline << feed.construct(params)
          @unauthed_accounts = feed.unauthed_accounts
        end
      end
      @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
    end
    # render 'home' is implicit.
  end

  def individual_post
    @post = {
    post_id: params[:post_id],
    provider: params[:provider],
    user: params[:user]
  }
    post_type = params[:post_type]
    if post_type == 'User'
      @user = User.find(@post[:user])
      @post_entry = Notification::Timeline.new(@post[:post_id],
                                               @post[:provider],
                                               @user).construct
    else
      @page = Page.find(@post[:user])
      @post_entry = Notification::Timeline.new(@post[:post_id],
                                               @post[:provider],
                                               @page).construct
    end
  end

  private
  # def find_page
  #   @page = Page.find_by(page_name: params[:action])
  # end

  def set_page
    @page = Page.where(page_name: params[:action]).first_or_create!
    impressionist(@page)
  end

  public

  def help; end
  def about; end
  def feedback; end
  def qanda; end
  def terms; end
  def privacy; end
  def business_connector; end
  def celebrity_connector; end
  def tv_show_connector; end
  def fashion_connector; end
  def youtubers; end
  def sports_connector; end
  def music_connector; end
  def food_connector; end
  def travel_connector; end
  def test_page
    m = {}
    m[:wired] = {image: 'wired', full_name: 'Wired', path: '/wired'}
    m[:national_geographic] = {image: 'NatGeo', full_name: 'NatGeo', path: '/nationalgeographic'}
    m[:people_magazine] = {image: 'people', full_name: 'People', path: '/peoplemagazine'}
    m[:time_magazine] = {image: 'TIME', full_name: 'TIME', path: '/timemagazine'}
    m[:sports_illustrated] = {image: 'sinow', full_name: 'Sports Illustrated', path: '/sportsillustrated'}
    m[:cosmopolitan] = {image: 'Cosmopolitan', full_name: 'Cosmopolitan', path: '/cosmopolitan'}
    m[:redbull] = {image: 'redbull', full_name: 'Redbull', path: '/redbull'}
    m[:espn] = {image: 'espn', full_name: 'ESPN', path: '/espn'}
    m[:us_weekly] = {image: 'usweekly', full_name: 'US Weekly', path: '/usweekly'}
    m[:entertainment_weekly] = {image: 'EW', full_name: 'Entertainment', path: '/entertainmentweekly'}
    m[:newsweek] = {image: 'Newsweek', full_name: 'Newsweek', path: '/newsweek'}
    m[:popular_science] = {image: 'PopSci', full_name: 'PopSci', path: '/popularscience'}
    m[:vogue] = {image: 'vougemagazine', full_name: 'Vogue', path: '/vogue'}
    m[:bloomberg_businessweekly] = {image: 'business', full_name: 'Bloomberg', path: '/bloomberg'}
    m[:gq] = {image: 'GQMagazine', full_name: 'GQ Magazine', path: '/gq'}
    m[:hgtv] = {image: 'hgtv', full_name: 'HGTV', path: '/hgtv'}
    m[:forbes_magazine] = {image: 'Forbes', full_name: 'Forbes', path: '/forbes'}
    m[:fortune] = {image: 'FortuneMagazine', full_name: 'Fortune', path: '/fortune'}
    m[:e_news] = {image: 'Enews', full_name: 'E! News', path: '/enews'}
    m[:google] = {image: 'google', full_name: 'Google', path: '/google'}
    m[:tedtalks] = {image: 'TEDTalks', full_name: 'TED Talks', path: '/tedtalks'}
    m[:tesla] = {image: 'TeslaMotors', full_name: 'Tesla', path: '/tesla'}
    m[:victorias_secret] = {image: 'VictoriasSecret', full_name: "Victoria's Secret", path: '/victoriassecret'}
    m[:cnn] = {image: 'CNN', full_name: 'CNN', path: '/cnn'}
    m[:hbo] = {image: 'HBO', full_name: 'HBO', path: '/hbo'}
    m[:showtime] = {image: 'SHO_Network', full_name: 'Showtime', path: '/showtime'}
    m[:marvel] = {image: 'Marvel', full_name: 'Marvel', path: '/marvel'}
    m[:syfy] = {image: 'SyfyTV', full_name: 'Syfy', path: '/syfy'}
    m[:netflix] = {image: 'netflix', full_name: 'Netflix', path: '/netflix'}
    m[:buzzfeed] = {image: 'Buzzfeed', full_name: 'Buzzfeed', path: '/buzzfeed'}
    m[:reddit] = {image: 'reddit', full_name: 'Reddit', path: '/reddit'}
    m[:collegehumor] = {image: 'CollegeHumor', full_name: 'CollegeH umor', path: '/collegehumor'}
    m[:microsoft] = {image: 'Microsoft', full_name: 'Microsoft', path: '/microsoft'}
    m[:nike] = {image: 'Nike', full_name: 'Nike', path: '/nike'}
    m[:imdb] = {image: 'IMDb', full_name: 'IMDb', path: '/imdb'}
    m[:vevo] = {image: 'Vevo', full_name: 'Vevo', path: '/vevo'}
    m[:starwars] = {image: 'starwars', full_name: 'Star Wars', path: '/starwars'}
    m[:nasa] = {image: 'NASA', full_name: 'NASA', path: '/nasa'}
    m[:bravo] = {image: 'Bravotv', full_name: 'Bravo', path: '/bravo'}
    m[:mtv] = {image: 'MTV', full_name: 'MTV', path: '/mtv'}
    m[:golfdigest] = {image: 'GolfDigest', full_name: 'Golf Digest', path: '/golfdigest'}
    m[:nba] = {image: 'NBA', full_name: 'NBA', path: '/nba'}
    m[:nfl] = {image: 'NFL', full_name: 'NFL', path: '/nfl'}
    m[:mlb] = {image: 'MLB', full_name: 'MLB', path: '/mlb'}
    m[:nhl] = {image: 'NHL', full_name: 'NHL', path: '/nhl'}
    m[:inc] = {image: 'Inc', full_name: 'Inc', path: '/inc'}
    m[:makerbot] = {image: 'makerbot', full_name: 'Makerbot', path: '/makerbot'}
    m[:olympics] = {image: 'Olympics', full_name: 'Olympics', path: '/olympics'}
    m[:tmz] = {image: 'TMZ', full_name: 'TMZ', path: '/tmz'}
    m[:tiffany] = {image: 'TiffanyandCo', full_name: 'Tiffany & Co', path: '/tiffany'}
    m[:playboy] = {image: 'Playboy', full_name: 'Playboy', path: '/playboy'}
    m[:maxim] = {image: 'MaximMag', full_name: 'Maxim', path: '/maxim'}
    m[:elle] = {image: 'ELLEmagazine', full_name: 'ELLE', path: '/elle'}
    m[:vanityfair] = {image: 'VanityFair', full_name: 'Vanity Fair', path: '/vanityfair'}
    m[:brides] = {image: 'brides', full_name: 'Brides', path: '/brides'}
    m[:usatoday] = {image: 'USATODAY', full_name: 'USA TODAY', path: '/usatoday'}
    m[:sciencechannel] = {image: 'ScienceChannel', full_name: 'Science Channel', path: '/sciencechannel'}
    m[:fifa] = {image: 'FIFAWorldCup', full_name: 'FIFA', path: '/fifa'}
    m[:gucci] = {image: 'gucci', full_name: 'Gucci', path: '/gucci'}
    m[:handm] = {image: 'hm', full_name: 'H & M', path: '/handm'}
    m[:generalelectric] = {image: 'generalelectric', full_name: 'General Electric', path: '/generalelectric'}
    m[:armani] = {image: 'armani', full_name: 'Armani', path: '/armani'}
    m[:ibm] = {image: 'IBM', full_name: 'IBM', path: '/ibm'}
    m[:foxsports] = {image: 'FOXSports', full_name: 'FOX Sports', path: '/foxsports'}
    m[:cnbc] = {image: 'CNBC', full_name: 'CNBC', path: '/cnbc'}
    m[:amazon] = {image: 'amazon', full_name: 'Amazon', path: '/amazon'}
    m[:food] = {image: 'FoodNetwork', full_name: 'Food Network', path: '/foodnetwork'}
    m[:sony] = {image: 'Sony', full_name: 'Sony', path: '/sony'}
    m[:gap] = {image: 'Gap', full_name: 'Gap', path: '/gap'}
    m[:history] = {image: 'HISTORY', full_name: 'History', path: '/history'}
    m[:ralph] = {image: 'RalphLauren', full_name: 'Ralph Lauren', path: '/ralphlauren'}
    m[:tlc] = {image: 'TLC', full_name: 'TLC', path: '/tlc'}
    m[:xbox] = {image: 'Xbox', full_name: 'Xbox', path: '/xbox'}
    m[:playstation] = {image: 'PlayStation', full_name: 'PlayStation', path: '/playstation'}
    m[:nordstrom] = {image: 'Nordstrom', full_name: 'Nordstrom', path: '/nordstrom'}
    m[:entrepreneur] = {image: 'Entrepreneur', full_name: 'Entrepreneur', path: '/entrepreneur'}
    m[:bananarepublic] = {image: 'BananaRepublic', full_name: 'Banana Republic', path: '/bananarepublic'}
    m[:calvinklein] = {image: 'CalvinKlein', full_name: 'Calvin Klein', path: '/calvinklein'}
    m[:underarmour] = {image: 'UnderArmour', full_name: 'Under Armour', path: '/underarmour'}
    m[:facebook] = {image: 'facebook', full_name: 'Facebook', path: '/facebook'}
    m[:burberry] = {image: 'Burberry', full_name: 'Burberry', path: '/burberry'}
    m[:abc] = {image: 'ABCNetwork', full_name: 'ABC', path: '/abc'}
    m[:nbc] = {image: 'nbc', full_name: 'NBC', path: '/nbc'}
    m[:cbs] = {image: 'cbs', full_name: 'CBS', path: '/cbs'}
    m[:thecw] = {image: 'CW_network', full_name: 'The CW', path: '/thecw'}
    m[:hugoboss] = {image: 'HUGOBOSS', full_name: 'Hugo Boss', path: '/hugoboss'}
    m[:cbsnews] = {image: 'CBSNews', full_name: 'CBS News', path: '/cbsnews'}
    m[:foxnews] = {image: 'FoxNews', full_name: 'Fox News', path: '/foxnews'}
    m[:nbcnews] = {image: 'NBCNews', full_name: 'NBC News', path: '/nbcnews'}
    m[:abcnews] = {image: 'ABC', full_name: 'ABC News', path: '/abcnews'}
    m[:cbssports] = {image: 'CBSSports', full_name: 'CBS Sports', path: '/cbssports'}
    m[:fox] = {image: 'FOXTV', full_name: 'FOX', path: '/fox'}
    m[:uber] = {image: 'Uber', full_name: 'Uber', path: '/uber'}
    m[:forever21] = {image: 'Forever21', full_name: 'Forever 21', path: '/forever21'}
    m[:mls] = {image: 'MLS', full_name: 'MLS', path: '/mls'}
    m[:urbanoutfitters] = {image: 'UrbanOutfitters', full_name: 'Urban Outfitters', path: '/urbanoutfitters'}
    m[:allure] = {image: 'Allure_magazine', full_name: 'Allure', path: '/allure'}
    m[:wmagazine] = {image: 'wmag', full_name: 'W Magazine', path: '/wmagazine'}
    m[:thescene] = {image: 'SCENE', full_name: 'The Scene', path: '/thescene'}
    m[:youtube] = {image: 'YouTube', full_name: 'YouTube', path: '/youtube'}
    m[:katyperry] = {image: 'katyperry', full_name: 'Katy Perry', path: '/katyperry'}
    m[:barackobama] = {image: 'BarackObama', full_name: 'Barack Obama', path: '/barackobama'}
    m[:taylorswift] = {image: 'taylorswift13', full_name: 'Taylor Swift', path: '/taylorswift'}
    m[:ladygaga] = {image: 'ladygaga', full_name: 'Lady Gaga', path: '/ladygaga'}
    m[:justintimberlake] = {image: 'jtimberlake', full_name: 'Justin Timberlake', path: '/justintimberlake'}
    m[:britneyspears] = {image: 'britneyspears', full_name: 'Britney Spears', path: '/britneyspears'}
    m[:kimkardashianwest] = {image: 'KimKardashian', full_name: 'Kim Kardashian', path: '/kimkardashianwest'}
    m[:shakira] = {image: 'shakira', full_name: 'Shakira', path: '/shakira'}
    m[:jenniferlopez] = {image: 'JLo', full_name: 'Jennifer Lopez', path: '/jenniferlopez'}
    m[:selenagomez] = {image: 'selenagomez', full_name: 'Selena Gomez', path: '/selenagomez'}
    m[:arianagrande] = {image: 'ArianaGrande', full_name: 'Ariana Grande', path: '/arianagrande'}
    m[:demilovato] = {image: 'ddlovato', full_name: 'Demi Lovato', path: '/demilovato'}
    m[:jimmyfallon] = {image: 'jimmyfallon', full_name: 'Jimmy Fallon', path: '/jimmyfallon'}
    m[:lebronjames] = {image: 'KingJames', full_name: 'LeBron James', path: '/lebronjames'}
    m[:adele] = {image: 'OfficialAdele', full_name: 'Adele', path: '/adele'}
    m[:brunomars] = {image: 'BrunoMars', full_name: 'Bruno Mars', path: '/brunomars'}
    m[:aliciakeys] = {image: 'aliciakeys', full_name: 'Alicia Keys', path: '/aliciakeys'}
    m[:mileyraycyrus] = {image: 'MileyCyrus', full_name: 'Miley Cyrus', path: '/mileyraycyrus'}
    m[:nickiminaj] = {image: 'NICKIMINAJ', full_name: 'Nicki Minaj', path: '/nickiminaj'}
    m[:emmawatson] = {image: 'EmWatson', full_name: 'Emma Watson', path: '/emmawatson'}
    m[:neilpatrickharris] = {image: 'ActuallyNPH', full_name: 'Neil Patrick Harris', path: '/neilpatrickharris'}
    m[:davidguetta] = {image: 'davidguetta', full_name: 'David Guetta', path: '/davidguetta'}
    m[:conanobrien] = {image: 'ConanOBrien', full_name: 'Conan OBrien', path: '/conanobrien'}
    m[:khloekardashian] = {image: 'KhloeKardashian', full_name: 'Khloe Kardashian', path: '/khloekardashian'}
    m[:kourtneykardashian] = {image: 'kourtneykardashian', full_name: 'Kourtney Kardashian', path: '/kourtneykardashian'}
    m[:christinaaguilera] = {image: 'xtina', full_name: 'Christina Aguilera', path: '/christinaaguilera'}
    m[:beyonce] = {image: 'Beyonce', full_name: 'Beyonce', path: '/beyonce'}
    m[:oprahwinfrey] = {image: 'Oprah', full_name: 'Oprah Winfrey', path: '/oprahwinfrey'}
    m[:johnnydepp] = {image: 'realdepp', full_name: 'Johnny Depp', path: '/johnnydepp'}
    m[:scarlettjohansson] = {image: 'ScarlettJOnline', full_name: 'Scarlett Johansson', path: '/scarlettjohansson'}
    m[:madonna] = {image: 'Madonna', full_name: 'Madonna', path: '/madonna'}
    m[:tomhanks] = {image: 'tomhanks', full_name: 'Tom Hanks', path: '/tomhanks'}
    m[:jessicaalba] = {image: 'jessicaalba', full_name: 'Jessica Alba', path: '/jessicaalba'}
    m[:meganfox] = {image: 'meganfox', full_name: 'Megan Fox', path: '/meganfox'}
    m[:tigerwoods] = {image: 'TigerWoods', full_name: 'Tiger Woods', path: '/tigerwoods'}
    m[:blakelively] = {image: 'blakelively', full_name: 'Blake Lively', path: '/blakelively'}
    m[:leonardodicaprio] = {image: 'LeoDiCaprio', full_name: 'Leonardo DiCaprio', path: '/leonardodicaprio'}
    m[:emmastone] = {image: 'EmmaStoneWeb', full_name: 'Emma Stone', path: '/emmastone'}
    m[:jayz] = {image: 'JayZClassicBars', full_name: 'jay Z', path: '/jayz'}
    m[:ellendegeneres] = {image: 'TheEllenShow', full_name: 'Ellen DeGeneres', path: '/ellendegeneres'}
    m[:sandrabullock] = {image: 'sbullockweb', full_name: 'Sandra Bullock', path: '/sandrabullock'}
    m[:ashleygreene] = {image: 'AshleyMGreene', full_name: 'Ashley Greene', path: '/ashleygreene'}
    m[:natalieportman] = {image: 'PortmanUpdate', full_name: 'Natalie Portman', path: '/natalieportman'}
    m[:jenniferlawrence] = {image: 'MsJenniferLaw', full_name: 'Jennifer Lawrence', path: '/jenniferlawrence'}
    m[:katebosworth] = {image: 'katebosworth', full_name: 'Kate Bosworth', path: '/katebosworth'}
    m[:camerondiaz] = {image: 'CameronDiaz', full_name: 'Cameron Diaz', path: '/camerondiaz'}
    m[:milakunis] = {image: 'Milla_Kunis', full_name: 'Milla Kunis', path: '/milakunis'}
    m[:floydmayweather] = {image: 'FloydMayweather', full_name: 'Floyd Mayweather', path: '/floydmayweather'}
    m[:reesewitherspoon] = {image: 'RWitherspoon', full_name: 'Reese Witherspoon', path: '/reesewitherspoon'}
    m[:kateupton] = {image: 'KateUpton', full_name: 'Kate Upton', path: '/kateupton'}
    m[:peterdinklage] = {image: 'Peter_Dinklage', full_name: 'Peter Dinklage', path: '/peterdinklage'}
    m[:armanifashion] = {image: 'armani', full_name: 'Armani', path: '/armanifashion'}
    m[:burberryfashion] = {image: 'Burberry', full_name: 'Burberry', path: '/burberryfashion'}
    m[:calvinkleinfashion] = {image: 'CalvinKlein', full_name: 'Calvin Klein', path: '/calvinkleinfashion'}
    m[:chanel] = {image: 'CHANEL', full_name: 'CHANEL', path: '/chanel'}
    m[:christiandior] = {image: 'Dior', full_name: 'Dior', path: '/christiandior'}
    m[:christianlouboutin] = {image: 'LouboutinWorld', full_name: 'Christian Louboutin', path: '/christianlouboutin'}
    m[:dolceandgabbana] = {image: 'dolcegabbana', full_name: 'Dolce and Gabbana', path: '/dolceandgabbana'}
    m[:dkny] = {image: 'dkny', full_name: 'DKNY', path: '/dkny'}
    m[:escada] = {image: 'ESCADA', full_name: 'ESCADA', path: '/escada'}
    m[:fendi] = {image: 'Fendi', full_name: 'Fendi', path: '/fendi'}
    m[:guccifashion] = {image: 'gucci', full_name: 'Gucci', path: '/guccifashion'}
    m[:prada] = {image: 'Prada', full_name: 'Prada', path: '/prada'}
    m[:hugobossfashion] = {image: 'HUGOBOSS', full_name: 'HUGO BOSS', path: '/hugobossfashion'}
    m[:johnvarvatos] = {image: 'johnvarvatos', full_name: 'John Varvatos', path: '/johnvarvatos'}
    m[:laperlalingerie] = {image: 'LaPerlaLingerie', full_name: 'La Perla Lingerie', path: '/laperlalingerie'}
    m[:louisvuitton] = {image: 'LouisVuitton', full_name: 'Louis Vuitton', path: '/louisvuitton'}
    m[:manoloblahnik] = {image: 'ManoloBlahnik', full_name: 'Manolo Blahnik', path: '/manoloblahnik'}
    m[:missoni] = {image: 'Missoni', full_name: 'Missoni', path: '/missoni'}
    m[:ralphlaurenfashion] = {image: 'RalphLauren', full_name: 'Ralph Lauren', path: '/ralphlaurenfashion'}
    m[:rolandmouret] = {image: 'RolandMouret', full_name: 'Roland Mouret', path: '/rolandmouret'}
    m[:stellamccartney] = {image: 'StellaMcCartney', full_name: 'Stella McCartney', path: '/stellamccartney'}
    m[:tomford] = {image: 'TOMFORD', full_name: 'TOM FORD', path: '/tomford'}
    m[:versace] = {image: 'Versace', full_name: 'Versace', path: '/versace'}
    m[:michaelkors] = {image: 'MichaelKors', full_name: 'Michael Kors', path: '/michaelkors'}
    m[:allrecipes] = {image: 'Allrecipes', full_name: 'All Recipes', path: '/allrecipes'}
    m[:cookingdotcom] = {image: 'CookingCom', full_name: 'Cooking.com', path: '/cookingdotcom'}
    m[:foodnetwork] = {image: 'FoodNetwork', full_name: 'Food Network', path: '/foodnetworkchannel'}
    m[:thekitchn] = {image: 'thekitchn', full_name: 'The Kitchn', path: '/thekitchn'}
    m[:opentable] = {image: 'OpenTable', full_name: 'Open Table', path: '/opentable'}
    m[:tasteofhome] = {image: 'tasteofhome', full_name: 'Taste Of Home', path: '/tasteofhome'}
    m[:epicurious] = {image: 'epicurious', full_name: 'Epicurious', path: '/epicurious'}
    m[:grubhub] = {image: 'GrubHub', full_name: 'Grub Hub', path: '/grubhub'}
    m[:seamless] = {image: 'Seamless', full_name: 'Seamless', path: '/seamless'}
    m[:yummly] = {image: 'yummly', full_name: 'Yummly', path: '/yummly'}
    m[:huffingtonpostfood] = {image: 'HuffPostFood', full_name: 'Huffington Post Food', path: '/huffingtonpostfood'}
    m[:fooddotcom] = {image: 'Fooddotcom', full_name: 'Food.com', path: '/fooddotcom'}
    m[:bonappetit] = {image: 'bonappetit', full_name: 'BonAppetit.com', path: '/bonappetit'}
    m[:weightwatchers] = {image: 'WeightWatchers', full_name: 'Weight Watchers', path: '/weightwatchers'}
    m[:foodandwine] = {image: 'FoodAndWineMag', full_name: 'Food And Wine', path: '/foodandwine'}
    m[:thechew] = {image: 'thechew', full_name: 'The Chew', path: '/thechew'}
    m[:americastestkitchen] = {image: 'TestKitchen', full_name: 'Americas Test Kitchen', path: '/americastestkitchen'}
    m[:ironchefamerica] = {image: 'IronChefAmerica', full_name: 'Iron Chef America', path: '/ironchefamerica'}
    m[:onedirection] = {image: 'onedirection', full_name: 'One Direction', path: '/onedirection'}
    m[:katyperrymusic] = {image: 'katyperry', full_name: 'Katy Perry', path: '/katyperrymusic'}
    m[:beyoncemusic] = {image: 'Beyonce', full_name: 'Beyonce', path: '/beyoncemusic'}
    m[:taylorswiftmusic] = {image: 'taylorswift13', full_name: 'Taylor Swift', path: '/taylorswiftmusic'}
    m[:justintimberlakemusic] = {image: 'jtimberlake', full_name: 'Justin Timberlake', path: '/justintimberlakemusic'}
    m[:iggyazalea] = {image: 'IGGYAZALEA', full_name: 'Iggy Azalea', path: '/iggyazalea'}
    m[:arianagrandemusic] = {image: 'ArianaGrande', full_name: 'Ariana Grande', path: '/arianagrandemusic'}
    m[:mileycyrus] = {image: 'MileyCyrus', full_name: 'Miley Cyrus', path: '/mileycyrus'}
    m[:pharrelwilliams] = {image: 'Pharrell', full_name: 'Pharrell Williams', path: '/pharrelwilliams'}
    m[:eminem] = {image: 'Eminem', full_name: 'Eminem', path: '/eminem'}
    m[:lorde] = {image: 'lordemusic', full_name: 'Lorde', path: '/lorde'}
    m[:lukebryan] = {image: 'LukeBryanOnline', full_name: 'Luke Bryan', path: '/lukebryan'}
    m[:samsmith] = {image: 'samsmithworld', full_name: 'Sam Smith', path: '/samsmith'}
    m[:johnlegend] = {image: 'johnlegend', full_name: 'John Legend', path: '/johnlegend'}
    m[:onerepublic] = {image: 'OneRepublic', full_name: 'One Republic', path: '/onerepublic'}
    m[:drake] = {image: 'Drake', full_name: 'Drake', path: '/drake'}
    m[:jasonderulo] = {image: 'jasonderulo', full_name: 'Jason Derulo', path: '/jasonderulo'}
    m[:justinbieber] = {image: 'justinbieber', full_name: 'Justin Bieber', path: '/justinbieber'}
    m[:imaginedragons] = {image: 'imaginedragons', full_name: 'Imagine Dragons', path: '/imaginedragons'}
    m[:floridageorgialine] = {image: 'FLAGALine', full_name: 'Florida Georgia Line', path: '/floridageorgialine'}
    m[:nickiminajmusic] = {image: 'NICKIMINAJ', full_name: 'Nicki Minaj', path: '/nickiminajmusic'}
    m[:secondsofsummer] = {image: '5SOS', full_name: '5 Seconds of Summer', path: '/secondsofsummer'}
    m[:ladygagamusic] = {image: 'ladygaga', full_name: 'Lady Gaga', path: '/ladygagamusic'}
    m[:pitbull] = {image: 'pitbull', full_name: 'Pitbull', path: '/pitbull'}
    m[:brunomarsmusic] = {image: 'BrunoMars', full_name: 'Bruno Mars', path: '/brunomarsmusic'}
    m[:jasonaldean] = {image: 'Jason_Aldean', full_name: 'Jason Aldean', path: '/jasonaldean'}
    m[:maroon5] = {image: 'maroon5', full_name: 'Maroon 5', path: '/maroon5'}
    m[:chrisbrown] = {image: 'chrisbrown', full_name: 'Chris Brown', path: '/chrisbrown'}
    m[:meghantrainor] = {image: 'Meghan_Trainor', full_name: 'Meghan Trainor', path: '/meghantrainor'}
    m[:bastille] = {image: 'bastilledan', full_name: 'Bastille', path: '/bastille'}
    m[:avicii] = {image: 'Avicii', full_name: 'Avicii', path: '/avicii'}
    m[:magic] = {image: 'ournameisMAGIC', full_name: 'Magic!', path: '/magic'}
    m[:demilovatomusic] = {image: 'ddlovato', full_name: 'Demi Lovato', path: '/demilovatomusic'}
    m[:blakeshelton] = {image: 'blakeshelton', full_name: 'Blake Shelton', path: '/blakeshelton'}
    m[:coldplay] = {image: 'coldplay', full_name: 'Coldplay', path: '/coldplay'}
    m[:charlixcx] = {image: 'charli_xcx', full_name: 'Charli XCX', path: '/charlixcx'}
    m[:nicoandvinz] = {image: 'NicoandVinz', full_name: 'Nico & Vinz', path: '/nicoandvinz'}
    m[:therollingstones] = {image: 'RollingStones', full_name: 'The Rolling Stones', path: '/therollingstones'}
    m[:shakiramusic] = {image: 'shakira', full_name: 'Shakira', path: '/shakiramusic'}
    m[:passenger] = {image: 'passengermusic', full_name: 'Passenger', path: '/passenger'}
    m[:brantleygilbert] = {image: 'BrantleyGilbert', full_name: 'Brantley Gilbert', path: '/brantleygilbert'}
    m[:elliegoulding] = {image: 'elliegoulding', full_name: 'Ellie Goulding', path: '/elliegoulding'}
    m[:ericchurch] = {image: 'ericchurch', full_name: 'Eric Church', path: '/ericchurch'}
    m[:idinamenzel] = {image: 'idinamenzel', full_name: 'Idina Menzel', path: '/idinamenzel'}
    m[:selenagomezmusic] = {image: 'selenagomez', full_name: 'Selena Gomez', path: '/selenagomezmusic'}
    m[:calvinharris] = {image: 'CalvinHarris', full_name: 'Calvin Harris', path: '/calvinharris'}
    m[:michaelbuble] = {image: 'michaelbuble', full_name: 'Michael Buble', path: '/michaelbuble'}
    m[:michaeljackson] = {image: 'michaeljackson', full_name: 'Michael Jackson', path: '/michaeljackson'}
    m[:britneyspearsmusic] = {image: 'britneyspears', full_name: 'Britney Spears', path: '/britneyspearsmusic'}
    m[:kellyclarkson] = {image: 'kelly_clarkson', full_name: 'Kelly Clarkson', path: '/kellyclarkson'}
    m[:christinaaguileramusic] = {image: 'xtina', full_name: 'Christinaa Guilera', path: '/christinaaguileramusic'}
    m[:realmadrid] = {image: 'realmadrid', full_name: 'Real Madrid', path: '/realmadrid'}
    m[:dallascowboys] = {image: 'dallascowboys', full_name: 'Dallas Cowboys', path: '/dallascowboys'}
    m[:newyorkyankees] = {image: 'Yankees', full_name: 'New York Yankees', path: '/newyorkyankees'}
    m[:barcelona] = {image: 'FCBarcelona', full_name: 'Barcelona', path: '/barcelona'}
    m[:manchesterunited] = {image: 'ManUtd', full_name: 'Manchester United', path: '/manchesterunited'}
    m[:losangeleslakers] = {image: 'Lakers', full_name: 'Los Angeles Lakers', path: '/losangeleslakers'}
    m[:newenglandpatriots] = {image: 'Patriots', full_name: 'New England Patriots', path: '/newenglandpatriots'}
    m[:newyorkknicks] = {image: 'nyknicks', full_name: 'New York KNicks', path: 'newyorkknicks'}
    m[:losangelesdodgers] = {image: 'Dodgers', full_name: 'Los Angeles Dodgers', path: '/losangelesdodgers'}
    m[:washingtonredskins] = {image: 'Redskins', full_name: 'Washington Redskins', path: '/washingtonredskins'}
    m[:bayernmunich] = {image: 'FCBayern', full_name: 'Bayern Munich', path: '/bayernmunich'}
    m[:bostonredsox] = {image: 'RedSox', full_name: 'Boston Red Sox', path: '/bostonredsox'}
    m[:newyorkgiants] = {image: 'Giants', full_name: 'New York Giants', path: '/newyorkgiants'}
    m[:chicagobulls] = {image: 'chicagobulls', full_name: 'Chicago Bulls', path: '/chicagobulls'}
    m[:sanfranciscogiants] = {image: 'SFGiants', full_name: 'San Francisco Giants', path: '/sanfranciscogiants'}
    m[:houstontexans] = {image: 'HoustonTexans', full_name: 'Houston Texans', path: '/houstontexans'}
    m[:chicagocubs] = {image: 'Cubs', full_name: 'Chicago Cubs', path: '/chicagocubs'}
    m[:newyorkjets] = {image: 'nyjets', full_name: 'New York Jets', path: '/newyorkjets'}
    m[:philadelphiaeagles] = {image: 'Eagles', full_name: 'Philadelphia Eagles', path: '/philadelphiaeagles'}
    m[:bostonceltics] = {image: 'celtics', full_name: 'Boston Celtics', path: '/bostonceltics'}
    m[:chicagobears] = {image: 'ChicagoBears', full_name: 'Chicago Bears', path: '/chicagobears'}
    m[:losangelesclippers] = {image: 'LAClippers', full_name: 'Los Angeles Clippers', path: '/losangelesclippers'}
    m[:sanfrancisco49ers] = {image: '49ers', full_name: 'San Francisco 49ers', path: '/sanfrancisco49ers'}
    m[:baltimoreravens] = {image: 'Ravens', full_name: 'Baltimore Ravens', path: '/baltimoreravens'}
    m[:brooklynnets] = {image: 'BrooklynNets', full_name: 'Brooklyn Nets', path: '/brooklynnets'}
    m[:denverbroncos] = {image: 'Broncos', full_name: 'Denver Broncos', path: '/denverbroncos'}
    m[:indianapoliscolts] = {image: 'Colts', full_name: 'Indianapolis Colts', path: '/indianapoliscolts'}
    m[:stlouiscardinals] = {image: 'Cardinals', full_name: 'St. Louis Cardinals', path: '/stlouiscardinals'}
    m[:greenbaypackers] = {image: 'packers', full_name: 'Greenbay Packers', path: '/greenbaypackers'}
    m[:manchestercity] = {image: 'MCFC', full_name: 'Manchester City', path: '/manchestercity'}
    m[:chelsea] = {image: 'ChelseaFC', full_name: 'Chelsea', path: '/chelsea'}
    m[:ferrari] = {image: 'Ferrari', full_name: 'Ferrari', path: '/ferrari'}
    m[:newyorkmets] = {image: 'Mets', full_name: 'New York Mets', path: '/newyorkmets'}
    m[:pittsburghsteelers] = {image: 'steelers', full_name: 'Pittsburgh Steelers', path: '/pittsburghsteelers'}
    m[:seattleseahawks] = {image: 'Seahawks', full_name: 'Seattle Seahawks', path: '/seattleseahawks'}
    m[:arsenal] = {image: 'Arsenal', full_name: 'Arsenal', path: '/arsenal'}
    m[:goldenstatewarriors] = {image: 'warriors', full_name: 'Golden State Warriors', path: '/goldenstatewarriors'}
    m[:losangelesangelsofanaheim] = {image: 'Angels', full_name: 'Angels of Anaheim', path: '/losangelesangelsofanaheim'}
    m[:miamidolphins] = {image: 'MiamiDolphins', full_name: 'Miami Dolphins', path: '/miamidolphins'}
    m[:torontomapleleafs] = {image: 'MapleLeafs', full_name: 'Toronto Maple Leafs', path: '/torontomapleleafs'}
    m[:washingtonnationals] = {image: 'Nationals', full_name: 'Washington Nationals', path: '/washingtonnationals'}
    m[:carolinapanthers] = {image: 'Panthers', full_name: 'Carolina Panthers', path: '/carolinapanthers'}
    m[:houstonrockets] = {image: 'HoustonRockets', full_name: 'Houston Rockets', path: '/houstonrockets'}
    m[:philadelphiaphillies] = {image: 'Phillies', full_name: 'Philadelphia Phillies', path: '/philadelphiaphillies'}
    m[:tampabaybuccaneers] = {image: 'TBBuccaneers', full_name: 'Tampa Bay Buccaneers', path: '/tampabaybuccaneers'}
    m[:texasrangers] = {image: 'Rangers', full_name: 'Texas Rangers', path: '/texasrangers'}
    m[:miamiheat] = {image: 'MiamiHEAT', full_name: 'Miami Heat', path: '/miamiheat'}
    m[:tennesseetitans] = {image: 'Titans', full_name: 'Tennessee Titans', path: '/tennesseetitans'}
    m[:atlantabraves] = {image: 'Braves', full_name: 'Atlanta Braves', path: '/atlantabraves'}
    m[:minnesotavikings] = {image: 'Vikings', full_name: 'Minnesota Vikings', path: '/minnesotavikings'}
    m[:arizonacardinals] = {image: 'AZCardinals', full_name: 'Arizona Cardinals', path: '/arizonacardinals'}
    m[:drewbinsky] = {image: 'drewbinsky7', full_name: 'Drew Binsky', path: '/drewbinsky'}
    m[:budgettravel] = {image: 'BudgetTravel', full_name: 'Budget Travel', path: '/budgettravel'}
    m[:afar] = {image: 'AFARmedia', full_name: 'Afar', path: '/afar'}
    m[:travelandleisure] = {image: 'TravelLeisure', full_name: 'Travel and Leisure', path: '/travelandleisure'}
    m[:condenasttraveler] = {image: 'CNTraveler', full_name: 'Condenast Traveler', path: '/condenasttraveler'}
    m[:geographical] = {image: 'GeographicalMag', full_name: 'Geographical', path: '/geographical'}
    m[:nationalgeographic] = {image: 'NatGeo', full_name: 'NatGeo', path: '/nationalgeographictravel'}
    m[:wanderlust] = {image: 'WanderlustFest', full_name: 'Wanderlust', path: '/wanderlust'}
    m[:lastweektonight] = {image: 'LastWeekTonight', full_name: 'Last Week Tonight', path: '/lastweektonight'}
    m[:gameofthrones] = {image: 'GameOfThrones', full_name: 'Game Of Thrones', path: '/gameofthrones'}
    m[:bettercallsaul] = {image: 'BetterCallSaul', full_name: 'BetterCallSaul', path: '/bettercallsaul'}
    m[:orangeisthenewblack] = {image: 'OITNB', full_name: 'Orange Is The New Black', path: '/orangeisthenewblack'}
    m[:empire] = {image: 'EmpireFox', full_name: 'Empir', path: '/empire'}
    m[:howimetyourmother] = {image: 'OfficialHIMYM', full_name: 'HIMYM', path: '/howimetyourmother'}
    m[:madmen] = {image: 'MadMen_AMC', full_name: 'Mad Men', path: '/madmen'}
    m[:theamericans] = {image: 'TheAmericansFX', full_name: 'The Americans', path: '/theamericans'}
    m[:thetonightshow] = {image: 'FallonTonight', full_name: 'THe Tonight Show', path: '/thetonightshow'}
    m[:truedetective] = {image: 'TrueDetective', full_name: 'True Detective', path: '/truedetective'}
    m[:justified] = {image: 'JustifiedFX', full_name: 'Justified', path: '/justified'}
    m[:sense8] = {image: 'sense8', full_name: 'Sense8', path: '/sense8'}
    m[:izombie] = {image: 'CWiZombie', full_name: 'iZombie', path: '/izombie'}
    m[:theflash] = {image: 'CW_TheFlash', full_name: 'The Flash', path: '/theflash'}
    m[:thebachelor] = {image: 'BachelorABC', full_name: 'The Bachelor', path: '/thebachelor'}
    m[:suits] = {image: 'Suits_USA', full_name: 'Suits', path: '/suits'}
    m[:theellenshow] = {image: 'TheEllenShow', full_name: 'The Ellen Show', path: '/theellenshow'}
    m[:greysanatomy] = {image: 'GreysABC', full_name: 'Greys Annotomy', path: '/greysanatomy'}
    m[:thewalkingdead] = {image: 'WalkingDead_AMC', full_name: 'The Walking Dead', path: '/thewalkingdead'}
    m[:americanhorrorstory] = {image: 'AmericanHorrorStory', full_name: 'American Horror Story', path: '/americanhorrorstory'}
    m[:sharktank] = {image: 'ABCSharkTank', full_name: 'Shark Tank', path: '/sharktank'}
    m[:gotham] = {image: 'Gotham', full_name: 'Gotham', path: '/gotham'}
    m[:thegoodwife] = {image: 'TheGoodWife_CBS', full_name: 'The Good Wife', path: '/thegoodwife'}
    m[:thebigbangtheory] = {image: 'BigBang_CBS', full_name: 'The Big Bang Theory', path: '/thebigbangtheory'}
    m[:theblacklist] = {image: 'NBCBlacklist', full_name: 'Blacklist', path: '/theblacklist'}
    m[:howtogetawaywithmurder] = {image: 'HowToGetAwayABC', full_name: 'How To Get Away With Murder', path: '/howtogetawaywithmurder'}
    m[:thevoice] = {image: 'NBCTheVoice', full_name: 'The Voice', path: '/thevoice'}
    m[:bachelorette] = {image: 'BacheloretteABC', full_name: 'Bachelorette', path: '/bachelorette'}
    m[:scandal] = {image: 'ScandalABC', full_name: 'Scandal', path: '/scandal'}
    m[:downtonabbey] = {image: 'DowntonAbbey', full_name: 'Downton Abbey', path: '/downtonabbey'}
    m[:dancingwiththestars] = {image: 'DancingABC', full_name: 'Dancing With the Stars', path: '/dancingwiththestars'}
    m[:americanidol] = {image: 'AmericanIdol', full_name: 'AmericanIdol', path: '/americanidol'}
    m[:thementalist] = {image: 'Mentalist_CBS', full_name: 'Mentalist', path: '/thementalist'}
    m[:houseofcards] = {image: 'HouseofCards', full_name: 'House of Cards', path: '/houseofcards'}
    m[:transparent] = {image: 'transparent_tv', full_name: 'Transparent', path: '/transparent'}
    m[:louie] = {image: 'LouieFX', full_name: 'Louie', path: '/louie'}
    m[:community] = {image: 'CommunityTV', full_name: 'Community', path: '/community'}
    m[:parksandrecreation] = {image: 'parksandrecnbc', full_name: 'Parks and Recreation', path: '/parksandrecreation'}
    m[:sonsofanarchy] = {image: 'SonsofAnarchy', full_name: 'Sons of Anarchy', path: '/sonsofanarchy'}
    m[:brooklynninenine] = {image: 'Brooklyn99FOX', full_name: 'Brooklyn 99', path: '/brooklynninenine'}
    m[:janethevirgin] = {image: 'CWJaneTheVirgin', full_name: 'Jane The Virgin', path: '/janethevirgin'}
    m[:fargo] = {image: 'FargoFX', full_name: 'Fargo', path: '/fargo'}
    m[:saturdaynightlive] = {image: 'nbcsnl', full_name: 'Saturday Night Live', path: '/saturdaynightlive'}
    m[:mrrobot] = {image: 'whoismrrobot', full_name: 'Mr. Robot', path: '/mrrobot'}
    m[:newgirl] = {image: 'NewGirlonFOX', full_name: 'New Girl', path: '/newgirl'}
    m[:scorpion] = {image: 'ScorpionCBS', full_name: 'Scorpion', path: '/scorpion'}
    m[:modernfamily] = {image: 'ModernFam', full_name: 'Modern Family', path: '/modernfamily'}
    m[:themindyproject] = {image: 'TheMindyProject', full_name: 'The Mindy Project', path: '/themindyproject'}
    m[:tyleroakley] = {image: 'tyleroakley', full_name: 'Tyler Oakley', path: '/tyleroakley'}
    m[:troyesivan] = {image: 'troyesivan', full_name: 'Troye Sivan', path: '/troyesivan'}
    m[:zoella] = {image: 'ZoellaBeauty', full_name: 'Zoella', path: '/zoella'}
    m[:connorfranta] = {image: 'ConnorFranta', full_name: 'Connor Franta', path: '/connorfranta'}
    m[:ijustine] = {image: 'ijustine', full_name: 'I Justine', path: '/ijustine'}
    m[:glozell] = {image: 'GloZell', full_name: 'GloZell', path: '/glozell'}
    m[:jennamarbles] = {image: 'Jenna_Marbles', full_name: 'Jenna Marbles', path: '/jennamarbles'}
    m[:alfiedeyes] = {image: 'PointlessBlog', full_name: 'Alfie Deyes', path: '/alfiedeyes'}
    m[:shanedawson] = {image: 'shanedawson', full_name: 'Shane Dawson', path: '/shanedawson'}
    m[:joeygraceffa] = {image: 'JoeyGraceffa', full_name: 'Joey Graceffa', path: '/joeygraceffa'}
    m[:rebeccablack] = {image: 'MsRebeccaBlack', full_name: 'Rebecca Black', path: '/rebeccablack'}
    m[:pewdiepie] = {image: 'pewdiepie', full_name: 'PewDiePie', path: '/pewdiepie'}
    m[:smosh] = {image: 'smosh', full_name: 'Smosh', path: '/smosh'}
    m[:nigahiga] = {image: 'Niga_Higa', full_name: 'Niga Higa', path: '/nigahiga'}
    m[:tobuscus] = {image: 'Tobuscus', full_name: 'Tobuscus', path: '/tobuscus'}
    m[:sawyerhartman] = {image: 'SawyerHartman', full_name: 'Sawyer Hartman', path: '/sawyerhartman'}
    m[:annoyingorange] = {image: 'annoyingorange', full_name: 'Annoying Orange', path: '/annoyingorange'}
    m[:rhettandlink] = {image: 'rhettandlink', full_name: 'Rhett and Link', path: '/rhettandlink'}
    m[:itskingsleybitch] = {image: 'kingsleyyy', full_name: 'ItsKingsleyBitch', path: '/itskingsleybitch'}
    m[:jimchapman] = {image: 'JimsTweetings', full_name: 'Jim Chapman', path: '/jimchapman'}
    m[:danisnotonfire] = {image: 'danisnotonfire', full_name: 'Dan Is Not On Fire', path: '/danisnotonfire'}
    m[:kickthepj] = {image: 'kickthepj', full_name: 'KickThePj', path: '/kickthepj'}
    m[:catrific] = {image: 'catrific', full_name: 'Catrific', path: '/catrific'}
    m[:tayzonday] = {image: 'TayZonday', full_name: 'Tay Zonday', path: '/tayzonday'}
    m[:marcusbutler] = {image: 'MarcusButler', full_name: 'Marcus Butler', path: '/marcusbutler'}
    m[:benjamincook] = {image: 'benjamin_cook', full_name: 'Benjamin Cook', path: '/benjamincook'}
    m[:olgakay] = {image: 'OlgaKay', full_name: 'Olga Kay', path: '/olgakay'}
    m[:hannahhart] = {image: 'harto', full_name: 'Hannah Hart', path: '/hannahhart'}
    m[:anthonypadilla] = {image: 'smoshanthony', full_name: 'Anthony Padilla', path: '/anthonypadilla'}
    m[:juliansmith] = {image: 'JulianWasHere', full_name: 'Julian Smith', path: '/juliansmith'}
    m[:amazingphil] = {image: 'AmazingPhil', full_name: 'Amazing Phil', path: '/amazingphil'}
    m[:sampepper] = {image: 'sampepper', full_name: 'Sam Pepper', path: '/sampepper'}
    @this_is_it = Hash[m.sort_by {|a, b| -Impression.where(action_name: a.to_s).count}]
    @test_pages = Kaminari.paginate_array(@this_is_it.to_a).page(params[:page]).per(3)
  end
  def mytop50; end
  def mostpopular; end
  def random; end
  def trending; end

  def wired
    # idx = session[:test_list].index()
    # @next_image = session[:test_list][idx + 1]
   #set_page
   @compname = 'Wired'
   @comp     = 'wired'
   @comp_url = 'https://www.youtube.com/user/wired'
   @incomp   = 'wired'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def wiredtestthing
   #set_page
   @compname = 'WiredTestThing'
   @comp     = 'blank'
   @comp_url = 'https://www.youtube.com/user/blank'
   @incomp   = 'wired'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def national_geographic
   @compname = 'NatGeo'
   @comp     = 'NatGeo'
   @comp_url = 'https://www.youtube.com/user/NationalGeographic'
   @incomp   = 'natgeo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def people_magazine
   @compname = 'People'
   @comp     = 'people'
   @comp_url = 'https://www.youtube.com/user/people'
   @incomp   = 'peoplemag'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def time_magazine
   @compname = 'Time'
   @comp     = 'TIME'
   @comp_url = 'https://www.youtube.com/user/TimeMagazine'
   @incomp   = 'time'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sports_illustrated
   @compname = 'Sports Illustrated'
   @comp     = 'sinow'
   @comp_url = 'https://www.youtube.com/user/SportsIllustrated'
   @incomp   = 'sportsillustrated'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cosmopolitan
   @compname = 'Cosmopolitan'
   @comp     = 'Cosmopolitan'
   @comp_url = 'https://www.youtube.com/user/HelloStyleChannel'
   @incomp   = 'cosmopolitan'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def redbull
   @compname = 'Redbull'
   @comp     = 'redbull'
   @comp_url = 'https://www.youtube.com/user/redbull'
   @incomp   = 'redbull'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def espn
   @compname = 'ESPN'
   @comp     = 'espn'
   @comp_url = 'https://www.youtube.com/user/ESPN'
   @incomp   = 'espn'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def us_weekly
   @compname = 'US Weekly'
   @comp     = 'usweekly'
   @comp_url = 'https://www.youtube.com/user/UsWeekly'
   @incomp   = 'usweekly'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def entertainment_weekly
   @compname = 'Entertainment'
   @comp     = 'EW'
   @comp_url = 'https://www.youtube.com/user/ew'
   @incomp   = 'entertainmentweekly'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newsweek
   @compname = 'Newsweek'
   @comp     = 'Newsweek'
   @comp_url = 'https://www.youtube.com/user/NewsweekVideo'
   @incomp   = 'newsweek'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def popular_science
   @compname = 'PopSci'
   @comp     = 'PopSci'
   @comp_url = 'https://www.youtube.com/user/Popscivideo'
   @incomp   = 'popsci'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def vogue
   @compname = 'Vogue'
   @comp     = 'vougemagazine'
   @comp_url = 'https://www.youtube.com/user/Americanvogue'
   @incomp   = 'vougemagazine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bloomberg_businessweekly
   @compname = 'Bloomberg'
   @comp     = 'business'
   @comp_url = 'https://www.youtube.com/user/Bloomberg'
   @incomp   = 'bloomberg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def gq
   @compname = 'GQ Magazine'
   @comp     = 'GQMagazine'
   @comp_url = 'https://www.youtube.com/user/GQVideos'
   @incomp   = 'gq'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def hgtv
   @compname = 'HGTV'
   @comp     = 'hgtv'
   @comp_url = 'https://www.youtube.com/user/HGTV'
   @incomp   = 'hgtv'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def forbes_magazine
   @compname = 'Forbes'
   @comp     = 'Forbes'
   @comp_url = 'https://www.youtube.com/user/forbes'
   @incomp   = 'forbes'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def fortune
   @compname = 'Fortune'
   @comp     = 'FortuneMagazine'
   @comp_url = 'https://www.youtube.com/user/FortuneMagazineVideo'
   @incomp   = 'fortunemag'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def e_news
   @compname = 'E! News'
   @comp     = 'Enews'
   @comp_url = 'https://www.youtube.com/user/enews'
   @incomp   = 'enews'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def google
   @compname = 'Google'
   @comp     = 'google'
   @comp_url = 'https://www.youtube.com/user/Google'
   @incomp   = 'google'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tedtalks
   @compname = 'TED Talks'
   @comp     = 'TEDTalks'
   @comp_url = 'https://www.youtube.com/user/TEDtalksDirector'
   @incomp   = 'ted'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tesla
   @compname = 'Tesla'
   @comp     = 'TeslaMotors'
   @comp_url = 'https://www.youtube.com/user/TeslaMotors'
   @incomp   = 'teslamotors'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def victorias_secret
   @compname = "Victoria's Secret"
   @comp     = 'VictoriasSecret'
   @comp_url = 'https://www.youtube.com/user/VICTORIASSECRET'
   @incomp   = 'victoriassecret'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cnn
   @compname = 'CNN'
   @comp     = 'CNN'
   @comp_url = 'https://www.youtube.com/user/CNN'
   @incomp   = 'cnn'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end


  def hbo
   @compname = 'HBO'
   @comp     = 'HBO'
   @comp_url = 'https://www.youtube.com/user/HBO'
   @incomp   = 'hbo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def showtime
   @compname = 'Showtime'
   @comp     = 'SHO_Network'
   @comp_url = 'https://www.youtube.com/user/SHOWTIME'
   @incomp   = 'showtime'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def marvel
   @compname = 'Marvel'
   @comp     = 'Marvel'
   @comp_url = 'https://www.youtube.com/user/MARVEL'
   @incomp   = 'marvel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def syfy
   @compname = 'Syfy'
   @comp     = 'SyfyTV'
   @comp_url = 'https://www.youtube.com/user/Syfy'
   @incomp   = 'syfy'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def netflix
   @compname = 'Netflix'
   @comp     = 'netflix'
   @comp_url = 'https://www.youtube.com/user/NewOnNetflix'
   @incomp   = 'netflix'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def buzzfeed
   @compname = 'Buzzfeed'
   @comp     = 'Buzzfeed'
   @comp_url = 'https://www.youtube.com/user/BuzzFeedVideo'
   @incomp   = 'buzzfeed'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def reddit
   @compname = 'Reddit'
   @comp     = 'reddit'
   @comp_url = 'https://www.youtube.com/user/reddit'
   @incomp   = 'reddit'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def collegehumor
   @compname = 'College Humor'
   @comp     = 'CollegeHumor'
   @comp_url = 'https://www.youtube.com/user/collegehumor'
   @incomp   = 'collegehumor'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def microsoft
   @compname = 'Microsoft'
   @comp     = 'Microsoft'
   @comp_url = 'https://www.youtube.com/user/Microsoft'
   @incomp   = 'microsoft'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nike
   @compname = 'Nike'
   @comp     = 'Nike'
   @comp_url = 'https://www.youtube.com/user/nike'
   @incomp   = 'nike'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def imdb
   @compname = 'IMDb'
   @comp     = 'IMDb'
   @comp_url = 'https://www.youtube.com/user/VideoIMDb'
   @incomp   = 'imdblive'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def vevo
   @compname = 'Vevo'
   @comp     = 'Vevo'
   @comp_url = 'https://www.youtube.com/user/VEVO'
   @incomp   = 'vevo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def starwars
   @compname = 'Star Wars'
   @comp     = 'starwars'
   @comp_url = 'https://www.youtube.com/user/starwars'
   @incomp   = 'starwars'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nasa
   @compname = 'NASA'
   @comp     = 'NASA'
   @comp_url = 'https://www.youtube.com/user/NASAtelevision'
   @incomp   = 'nasa'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bravo
   @compname = 'Bravo'
   @comp     = 'Bravotv'
   @comp_url = 'https://www.youtube.com/user/BravoShows'
   @incomp   = 'bravotv'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def mtv
   @compname = 'MTV'
   @comp     = 'MTV'
   @comp_url = 'https://www.youtube.com/user/MTV'
   @incomp   = 'mtv'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp' 
  end

  def golfdigest
   @compname = 'Golf Digest'
   @comp     = 'GolfDigest'
   @comp_url = 'https://www.youtube.com/user/GolfDigestMagazine'
   @incomp   = 'golfdigest'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nba
   @compname = 'NBA'
   @comp     = 'NBA'
   @comp_url = 'https://www.youtube.com/user/NBA'
   @incomp   = 'nba'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nfl
   @compname = 'NFL'
   @comp     = 'NFL'
   @comp_url = 'https://www.youtube.com/user/NFL'
   @incomp   = 'nfl'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def mlb
   @compname = 'MLB'
   @comp     = 'MLB'
   @comp_url = 'https://www.youtube.com/user/MLB'
   @incomp   = 'mlb'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nhl
   @compname = 'NHL'
   @comp     = 'NHL'
   @incomp   = 'nhl'
   @comp_url = 'https://www.youtube.com/user/NHLVideo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def inc
   @compname = 'Inc.'
   @comp     = 'Inc'
   @incomp   = 'incmagazine'
   @comp_url = 'https://www.youtube.com/user/incmagazine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def makerbot
   @compname = 'Makerbot'
   @comp     = 'makerbot'
   @incomp   = 'makerbot'
   @comp_url = 'https://www.youtube.com/user/makerbot'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def olympics
   @compname = 'Olympics'
   @comp     = 'Olympics'
   @incomp   = 'olympics'
   @comp_url = 'https://www.youtube.com/user/olympic'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tmz
   @compname = 'TMZ'
   @comp     = 'TMZ'
   @incomp   = 'tmz_tv'
   @comp_url = 'https://www.youtube.com/user/TMZ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tiffany
   @compname = 'Tiffany & Co'
   @comp     = 'TiffanyandCo'
   @incomp   = 'tiffanyandco'
   @comp_url = 'https://www.youtube.com/user/OfficialTiffanyAndCo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def playboy
   @compname = 'Playboy'
   @comp     = 'Playboy'
   @incomp   = 'playboy'
   @comp_url = 'https://www.youtube.com/user/playboy'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def maxim
   @compname = 'Maxim'
   @comp     = 'MaximMag'
   @incomp   = 'maximmag'
   @comp_url = 'https://www.youtube.com/user/videosbyMaxim'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def elle
   @compname = 'Elle'
   @comp     = 'ELLEmagazine'
   @incomp   = 'elleusa'
   @comp_url = 'https://www.youtube.com/user/ElleMagazine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def vanityfair
   @compname = 'Vanity Fair'
   @comp     = 'VanityFair'
   @incomp   = 'vanityfair'
   @comp_url = 'https://www.youtube.com/user/VanityFairMagazine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def brides
   @compname = 'Brides'
   @comp     = 'brides'
   @incomp   = 'brides'
   @comp_url = 'https://www.youtube.com/user/BridesMagazine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def usatoday
   @compname = 'USA Today'
   @comp     = 'USATODAY'
   @incomp   = 'usatoday'
   @comp_url = 'https://www.youtube.com/user/USATODAY'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sciencechannel
   @compname = 'Science Channel'
   @comp     = 'ScienceChannel'
   @incomp   = 'sciencechannel'
   @comp_url = 'https://www.youtube.com/user/ScienceChannel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def fifa
   @compname = 'FIFA'
   @comp     = 'FIFAWorldCup'
   @incomp   = 'fifaworldcup'
   @comp_url = 'https://www.youtube.com/user/FIFATV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def gucci
   @compname = 'Gucci'
   @comp     = 'gucci'
   @incomp   = 'gucci'
   @comp_url = 'https://www.youtube.com/user/gucciofficial'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def handm
   @compname = 'H&M'
   @comp     = 'hm'
   @incomp   = 'hm'
   @comp_url = 'https://www.youtube.com/user/hennesandmauritz'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def generalelectric
   @compname = 'General Electric'
   @comp     = 'generalelectric'
   @incomp   = 'generalelectric'
   @comp_url = 'https://www.youtube.com/user/GE'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ibm
   @compname = 'IBM'
   @comp     = 'IBM'
   @incomp   = 'ibm'
   @comp_url = 'https://www.youtube.com/user/IBM'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def armani
   @compname = 'Armani'
   @comp     = 'armani'
   @incomp   = 'armai'
   @comp_url = 'https://www.youtube.com/user/Armani'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def foxsports
   @compname = 'Fox Sports'
   @comp     = 'FOXSports'
   @incomp   = 'foxsports'
   @comp_url = 'https://www.youtube.com/user/FoxSports'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cnbc
   @compname = 'CNBC'
   @comp     = 'CNBC'
   @incomp   = 'cnbc'
   @comp_url = 'https://www.youtube.com/user/cnbc'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def amazon
   @compname = 'Amazon'
   @comp     = 'amazon'
   @incomp   = 'amazon'
   @comp_url = 'https://www.youtube.com/user/amazon'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def food
   @compname = 'Food Network'
   @comp     = 'FoodNetwork'
   @incomp   = 'foodnetwork'
   @comp_url = 'https://www.youtube.com/user/FoodNetworkTV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sony
   @compname = 'Sony'
   @comp     = 'Sony'
   @incomp   = 'sony'
   @comp_url = 'https://www.youtube.com/user/Sonyelectronics'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def gap
   @compname = 'Gap'
   @comp     = 'Gap'
   @incomp   = 'gap'
   @comp_url = 'https://www.youtube.com/user/Gap'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def history
   @compname = 'History'
   @comp     = 'HISTORY'
   @incomp   = 'history'
   @comp_url = 'https://www.youtube.com/user/historychannel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ralph
   @compname = 'Ralph Lauren'
   @comp     = 'RalphLauren'
   @incomp   = 'ralphlauren'
   @comp_url = 'https://www.youtube.com/user/RLTVralphlauren'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tlc
   @compname = 'TLC'
   @comp     = 'TLC'
   @incomp   = 'tlc'
   @comp_url = 'https://www.youtube.com/user/TLC'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def xbox
   @compname = 'Xbox'
   @comp     = 'Xbox'
   @incomp   = 'xbox'
   @comp_url = 'https://www.youtube.com/user/xbox'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def playstation
   @compname = 'PlayStation'
   @comp     = 'PlayStation'
   @incomp   = 'playstation'
   @comp_url = 'https://www.youtube.com/user/PlayStation'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nordstrom
   @compname = 'Nordstrom'
   @comp     = 'Nordstrom'
   @incomp   = 'nordstrom'
   @comp_url = 'https://www.youtube.com/user/Nordstromcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def entrepreneur
   @compname = 'Entrepreneur'
   @comp     = 'Entrepreneur'
   @incomp   = 'Entrepreneur'
   @comp_url = 'https://www.youtube.com/user/EntrepreneurOnline'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bananarepublic
   @compname = 'Banana Republic'
   @comp     = 'BananaRepublic'
   @incomp   = 'bananarepublic'
   @comp_url = 'https://www.youtube.com/user/bananarepublic'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def calvinklein
   @compname = 'Calvin Klein'
   @comp     = 'CalvinKlein'
   @incomp   = 'calvinklein'
   @comp_url = 'https://www.youtube.com/user/calvinklein'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def underarmour
   @compname = 'Under Armour'
   @comp     = 'UnderArmour'
   @incomp   = 'underarmour'
   @comp_url = 'https://www.youtube.com/user/underarmour'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def facebook
   @compname = 'Facebook'
   @comp     = 'facebook'
   @incomp   = 'facebook'
   @comp_url = 'https://www.youtube.com/user/theofficialfacebook'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def burberry
   @compname = 'Burberry'
   @comp     = 'Burberry'
   @incomp   = 'burberry'
   @comp_url = 'https://www.youtube.com/user/Burberry'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def abc
   @compname = 'ABC'
   @comp     = 'ABCNetwork'
   @incomp   = 'abcnetwork'
   @comp_url = 'https://www.youtube.com/user/ABCNetwork'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nbc
   @compname = 'NBC'
   @comp     = 'nbc'
   @incomp   = 'nbctv'
   @comp_url = 'https://www.youtube.com/user/NBC'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cbs
   @compname = 'CBS'
   @comp     = 'cbs'
   @incomp   = 'cbstv'
   @comp_url = 'https://www.youtube.com/user/CBS'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thecw
   @compname = 'The CW'
   @comp     = 'CW_network'
   @incomp   = 'thecw'
   @comp_url = 'https://www.youtube.com/user/Cwtelevision'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def hugoboss
   @compname = 'Hugo Boss'
   @comp     = 'HUGOBOSS'
   @incomp   = 'hugoboss'
   @comp_url = 'https://www.youtube.com/user/HUGOBOSSTV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cbsnews
   @compname = 'CBS News'
   @comp     = 'CBSNews'
   @incomp   = 'cbsnews'
   @comp_url = 'https://www.youtube.com/user/CBSNewsOnline'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def foxnews
   @compname = 'Fox News'
   @comp     = 'FoxNews'
   @incomp   = 'foxnews'
   @comp_url = 'https://www.youtube.com/user/FoxNewsChannel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nbcnews
   @compname = 'NBC News'
   @comp     = 'NBCNews'
   @incomp   = 'nbcnews'
   @comp_url = 'https://www.youtube.com/user/NBCNews'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def abcnews
   @compname = 'ABC News'
   @comp     = 'ABC'
   @incomp   = 'abcnews'
   @comp_url = 'https://www.youtube.com/user/ABCNews'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cbssports
   @compname = 'CBS Sports'
   @comp     = 'CBSSports'
   @incomp   = 'cbssports'
   @comp_url = 'https://www.youtube.com/user/CBSSports'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def fox
   @compname = 'Fox'
   @comp     = 'FOXTV'
   @incomp   = 'foxtv'
   @comp_url = 'https://www.youtube.com/user/FoxBroadcasting'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def uber
   @compname = 'Uber'
   @comp     = 'Uber'
   @incomp   = 'uber'
   @comp_url = 'https://www.youtube.com/user/UberWorldwide'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def forever21
   @compname = 'Forever 21'
   @comp     = 'Forever21'
   @incomp   = 'forever21'
   @comp_url = 'https://www.youtube.com/user/Forever21Inc'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def mls
   @compname = 'MLS'
   @comp     = 'MLS'
   @incomp   = 'mls'
   @comp_url = 'https://www.youtube.com/user/mls'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def urbanoutfitters
   @compname = 'Urban Outfitters'
   @comp     = 'UrbanOutfitters'
   @incomp   = 'urbanoutfitters'
   @comp_url = 'https://www.youtube.com/user/uotv'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def allure
   @compname = 'Allure'
   @comp     = 'Allure_magazine'
   @incomp   = 'allure'
   @comp_url = 'https://www.youtube.com/user/AllureMagazine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def wmagazine
   @compname = 'W Magazine'
   @comp     = 'wmag'
   @incomp   = 'wmag'
   @comp_url = 'https://www.youtube.com/user/wmagazinedotcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thescene
   @compname = 'The Scene'
   @comp     = 'SCENE'
   @incomp   = 'thescene'
   @comp_url = 'https://www.youtube.com/user/thesceneYT'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def youtube
   @compname = 'YouTube'
   @comp     = 'YouTube'
   @incomp   = 'youtube'
   @comp_url = 'https://www.youtube.com/user/Youtube'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def katyperry
   @compname = 'Katy Perry'
   @comp     = 'katyperry'
   @incomp   = 'katyperry'
   @comp_url = 'https://www.youtube.com/user/KatyPerryVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def barackobama
   @compname = 'Barack Obama'
   @comp     = 'BarackObama'
   @incomp   = 'barackobama'
   @comp_url = 'https://www.youtube.com/user/BarackObamadotcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def taylorswift
   @compname = 'Taylor Swift'
   @comp     = 'taylorswift13'
   @incomp   = 'taylorswift'
   @comp_url = 'https://www.youtube.com/user/TaylorSwiftVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ladygaga
   @compname = 'Lady Gaga'
   @comp     = 'ladygaga'
   @incomp   = 'ladygaga'
   @comp_url = 'https://www.youtube.com/user/LadyGagaVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def justintimberlake
   @compname = 'Justin Timberlake'
   @comp     = 'jtimberlake'
   @incomp   = 'justintimberlake'
   @comp_url = 'https://www.youtube.com/user/justintimberlakeVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def britneyspears
   @compname = 'Britney Spears'
   @comp     = 'britneyspears'
   @incomp   = 'britneyspears'
   @comp_url = 'https://www.youtube.com/user/BritneySpearsVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def kimkardashianwest
   @compname = 'Kim Kardashian'
   @comp     = 'KimKardashian'
   @incomp   = 'kimkardashian'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def shakira
   @compname = 'Shakira'
   @comp     = 'shakira'
   @incomp   = 'shakira'
   @comp_url = 'https://www.youtube.com/user/shakiraVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jenniferlopez
   @compname = 'Jennifer Lopez'
   @comp     = 'JLo'
   @incomp   = 'jlo'
   @comp_url = 'https://www.youtube.com/user/JenniferLopez'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def selenagomez
   @compname = 'Selena Gomez'
   @comp     = 'selenagomez'
   @incomp   = 'selenagomez'
   @comp_url = 'https://www.youtube.com/user/SelenaGomezVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def arianagrande
   @compname = 'Ariana Grande'
   @comp     = 'ArianaGrande'
   @incomp   = 'arianagrande'
   @comp_url = 'https://www.youtube.com/user/ArianaGrandeVevo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def demilovato
   @compname = 'Demi Lovato'
   @comp     = 'ddlovato'
   @incomp   = 'ddlovato'
   @comp_url = 'https://www.youtube.com/user/DemiLovatoVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jimmyfallon
   @compname = 'Jimmy Fallon'
   @comp     = 'jimmyfallon'
   @incomp   = 'jimmyfallon'
   @comp_url = 'https://www.youtube.com/user/latenight'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def lebronjames
   @compname = 'LeBron James'
   @comp     = 'KingJames'
   @incomp   = 'kingjames'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def adele
   @compname = 'Adele'
   @comp     = 'OfficialAdele'
   @incomp   = 'adele'
   @comp_url = 'https://www.youtube.com/user/AdeleVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def brunomars
   @compname = 'Bruno Mars'
   @comp     = 'BrunoMars'
   @incomp   = 'brunomars'
   @comp_url = 'https://www.youtube.com/user/ElektraRecords'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def aliciakeys
   @compname = 'Alicia Keys'
   @comp     = 'aliciakeys'
   @incomp   = 'aliciakeys'
   @comp_url = 'https://www.youtube.com/user/aliciakeysVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def mileyraycyrus
   @compname = 'Miley Cyrus'
   @comp     = 'MileyCyrus'
   @incomp   = 'mileycyrus'
   @comp_url = 'https://www.youtube.com/user/MileyCyrusVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nickiminaj
   @compname = 'Nicki Minaj'
   @comp     = 'NICKIMINAJ'
   @incomp   = 'nickiminaj'
   @comp_url = 'https://www.youtube.com/user/NickiMinajAtVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def emmawatson
   @compname = 'Emma Watson'
   @comp     = 'EmWatson'
   @incomp   = 'emmawatson'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def neilpatrickharris
   @compname = 'Neil Patrick Harris'
   @comp     = 'ActuallyNPH'
   @incomp   = 'nph'
   @comp_url = 'https://www.youtube.com/channel/UCk_Dx67t-aXqw9uQLVX-UCQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def davidguetta
   @compname = 'David Guetta'
   @comp     = 'davidguetta'
   @incomp   = 'davidguetta'
   @comp_url = 'https://www.youtube.com/user/davidguettavevo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def conanobrien
   @compname = 'Conan OBrien'
   @comp     = 'ConanOBrien'
   @incomp   = 'teamcoco'
   @comp_url = 'https://www.youtube.com/user/teamcoco'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def khloekardashian
   @compname = 'Khloe Kardashian'
   @comp     = 'KhloeKardashian'
   @incomp   = 'khloekardashianthegirl'
   @comp_url = 'https://www.youtube.com/channel/UCJy0RHFC64EC-kqWOfhCb_g'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def kourtneykardashian
   @compname = 'Kourtney Kardashian'
   @comp     = 'kourtneykardashian'
   @incomp   = 'kourtneykardash'
   @comp_url = 'https://www.youtube.com/channel/UCXIf9YuOaiCSn2r4P5SZ_Zw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def christinaaguilera
   @compname = 'Christina Aguilera'
   @comp     = 'xtina'
   @incomp   = 'xtina'
   @comp_url = 'https://www.youtube.com/user/CAguileraVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def beyonce
   @compname = 'Beyonce'
   @comp     = 'Beyonce'
   @incomp   = 'beyonce'
   @comp_url = 'https://www.youtube.com/user/beyonceVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def oprahwinfrey
   @compname = 'Oprah Winfrey'
   @comp     = 'Oprah'
   @incomp   = 'oprah'
   @comp_url = 'https://www.youtube.com/channel/UCqL0gza-KJcuVe3e0FCbM8Q'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def johnnydepp
   @compname = 'Johnny Depp'
   @comp     = 'realdepp'
   @incomp   = 'johnnydepp.oficial'
   @comp_url = 'https://www.youtube.com/channel/UCPP2obRMCcnokAqR4NzMuwQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def scarlettjohansson
   @compname = 'Scarlett Johansson'
   @comp     = 'ScarlettJOnline'
   @incomp   = 'scarlettjohanssonaddict'
   @comp_url = 'https://www.youtube.com/channel/UCuaGAGmxgipdJEOrYaMT0Nw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def madonna
   @compname = 'Madonna'
   @comp     = 'Madonna'
   @incomp   = 'madonna'
   @comp_url = 'https://www.youtube.com/user/madonna'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tomhanks
   @compname = 'Tom Hanks'
   @comp     = 'tomhanks'
   @incomp   = 'tomhanks'
   @comp_url = 'https://www.youtube.com/user/tomhankschannel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jessicaalba
   @compname = 'Jessica Alba'
   @comp     = 'jessicaalba'
   @incomp   = 'jessicaalba'
   @comp_url = 'https://www.youtube.com/channel/UCPJorwl_vxgiNni6Mas8a7A'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def meganfox
   @compname = 'Megan Fox'
   @comp     = 'meganfox'
   @incomp   = 'dailymeganfox'
   @comp_url = 'https://www.youtube.com/channel/UCsN68XRv5dVieQizOcLyzOg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tigerwoods
   @compname = 'Tiger Woods'
   @comp     = 'TigerWoods'
   @incomp   = 'TigerWoods'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def blakelively
   @compname = 'Blake Lively'
   @comp     = 'blakelively'
   @incomp   = 'blakelively'
   @comp_url = 'https://www.youtube.com/channel/UCKMKpIg3ZXn-7_xr4RAuQjA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def leonardodicaprio
   @compname = 'Leonardo DiCaprio'
   @comp     = 'LeoDiCaprio'
   @incomp   = 'leonardodicaprio'
   @comp_url = 'https://www.youtube.com/channel/UCc5HhOHhTKOMK_ta2lqtKgw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def emmastone
   @compname = 'Emma Stone'
   @comp     = 'EmmaStoneWeb'
   @incomp   = 'emmastone_official_'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jayz
   @compname = 'Jay Z'
   @comp     = 'JayZClassicBars'
   @incomp   = 'shawn.carter '
   @comp_url = 'https://www.youtube.com/user/JayZVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ellendegeneres
   @compname = 'Ellen DeGeneres'
   @comp     = 'TheEllenShow'
   @incomp   = 'theellenshow'
   @comp_url = 'https://www.youtube.com/user/TheEllenShow'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sandrabullock
   @compname = 'Sandra Bullock'
   @comp     = 'sbullockweb'
   @incomp   = 'sandrabullockig'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ashleygreene
   @compname = 'Ashley Greene'
   @comp     = 'AshleyMGreene'
   @incomp   = 'ashleygreene'
   @comp_url = 'https://www.youtube.com/channel/UCEHOQe7Kk_4F6LvAcPp1SKQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def natalieportman
   @compname = 'Natalie Portman'
   @comp     = 'PortmanUpdate'
   @incomp   = 'natalieportmanlove'
   @comp_url = 'https://www.youtube.com/channel/UC7M0_DE8EhWTpSgRqiuToCA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jenniferlawrence
   @compname = 'Jennifer Lawrence'
   @comp     = 'MsJenniferLaw'
   @incomp   = 'jenniferlawrencepx'
   @comp_url = 'https://www.youtube.com/channel/UC1SBXt6T5VT12_UFUupLWXA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def katebosworth
   @compname = 'Kate Bosworth'
   @comp     = 'katebosworth'
   @incomp   = 'katebosworth'
   @comp_url = 'https://www.youtube.com/channel/UC-jXKCYtzcMjBr8f66hyEvA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def camerondiaz
   @compname = 'Cameron Diaz'
   @comp     = 'CameronDiaz'
   @incomp   = 'camerondiaz'
   @comp_url = 'https://www.youtube.com/channel/UC9k-NlU7gjr8F0HlCTAWlXQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def floydmayweather
   @compname = 'Floyd Mayweather'
   @comp     = 'FloydMayweather'
   @incomp   = 'floydmayweather'
   @comp_url = 'https://www.youtube.com/user/FloydMayweather'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def reesewitherspoon
   @compname = 'Reese Witherspoon'
   @comp     = 'RWitherspoon'
   @incomp   = 'reesewitherspoon'
   @comp_url = 'https://www.youtube.com/channel/UCE20hbhrnFW3bhndXukSxAg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def kateupton
   @compname = 'Kate Upton'
   @comp     = 'KateUpton'
   @incomp   = 'kateupton'
   @comp_url = 'https://www.youtube.com/channel/UCyXW3LwGzBo1gQ8DOg7L5Nw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def peterdinklage
   @compname = 'Peter Dinklage'
   @comp     = 'Peter_Dinklage'
   @incomp   = 'peterdinklage'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def milakunis
   @compname = 'Milla Kunis'
   @comp     = 'Milla_Kunis'
   @incomp   = 'milakunis______'
   @comp_url = 'https://www.youtube.com/channel/UCl6qhIrV6It5TCyjS6Cq2lg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  #####TVSHOWS

  def lastweektonight
   @compname = 'Last Week Tonight'
   @comp     = 'LastWeekTonight'
   @incomp   = 'lastweektonight'
   @comp_url = 'https://www.youtube.com/user/LastWeekTonight'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def gameofthrones
   @compname = 'Game Of Thrones'
   @comp     = 'GameOfThrones'
   @incomp   = 'gameofthrones'
   @comp_url = 'https://www.youtube.com/user/GameofThrones'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bettercallsaul
   @compname = 'Better Call Saul'
   @comp     = 'BetterCallSaul'
   @incomp   = 'bettercallsaulamc'
   @comp_url = 'https://www.youtube.com/channel/UCCab9hOn5MELbKB__AOU3RQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def orangeisthenewblack
   @compname = 'Orange Is The New Black'
   @comp     = 'OITNB'
   @incomp   = 'oitnb'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def empire
   @compname = 'Empire'
   @comp     = 'EmpireFox'
   @incomp   = 'empirefox'
   @comp_url = 'https://www.youtube.com/user/EMPIREonFOX'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def howimetyourmother
   @compname = 'HIMYM'
   @comp     = 'OfficialHIMYM'
   @incomp   = 'himym_official'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def madmen
   @compname = 'Mad Men'
   @comp     = 'MadMen_AMC'
   @incomp   = 'madmen_amc'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def theamericans
   @compname = 'The Americans'
   @comp     = 'TheAmericansFX'
   @incomp   = 'theamericansfx'
   @comp_url = 'https://www.youtube.com/user/TheAmericansFX'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thetonightshow
   @compname = 'The Tonight Show'
   @comp     = 'FallonTonight'
   @incomp   = 'fallontonight'
   @comp_url = 'https://www.youtube.com/user/latenight'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def truedetective
   @compname = 'True Detective'
   @comp     = 'TrueDetective'
   @incomp   = 'truedetective'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def justified
   @compname = 'Justified'
   @comp     = 'JustifiedFX'
   @incomp   = 'justifiedfx'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sense8
   @compname = 'Sense8'
   @comp     = 'sense8'
   @incomp   = 'sense8'
   @comp_url = 'https://www.youtube.com/channel/UC7Vsk1omEqLSbxKdnSqYvXw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def izombie
   @compname = 'iZombie'
   @comp     = 'CWiZombie'
   @incomp   = 'thecwizombie'
   @comp_url = 'https://www.youtube.com/channel/UCtgIz5m-kWXdHOPYLp5Banw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def theflash
   @compname = 'The Flash'
   @comp     = 'CW_TheFlash'
   @incomp   = 'cwtheflash'
   @comp_url = 'https://www.youtube.com/user/barryallentheflash1'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thebachelor
   @compname = 'The Bachelor'
   @comp     = 'BachelorABC'
   @incomp   = 'bachelorabc'
   @comp_url = 'https://www.youtube.com/channel/UCXyOZBTth57gdz6k7KPHOsw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def suits
   @compname = 'Suits'
   @comp     = 'Suits_USA'
   @incomp   = 'suits_usa'
   @comp_url = 'https://www.youtube.com/user/SuitsonUSA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def theellenshow
   @compname = 'The Ellen Show'
   @comp     = 'TheEllenShow'
   @incomp   = 'theellenshow'
   @comp_url = 'https://www.youtube.com/user/TheEllenShow'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def greysanatomy
   @compname = 'Greys Anatomy'
   @comp     = 'GreysABC'
   @incomp   = 'greysabc'
   @comp_url = 'https://www.youtube.com/channel/UC5lWD_N9kq8IdWzLOdy5fow'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thewalkingdead
   @compname = 'The Walking Dead'
   @comp     = 'WalkingDead_AMC'
   @incomp   = 'amcthewalkingdead'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def americanhorrorstory
   @compname = 'American Horror Story'
   @comp     = 'AmericanHorrorStory'
   @incomp   = 'americanhorrorstory'
   @comp_url = 'https://www.youtube.com/user/qwerty19107'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sharktank
   @compname = 'Shark Tank'
   @comp     = 'ABCSharkTank'
   @incomp   = 'sharktankabc'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def gotham
   @compname = 'Gotham'
   @comp     = 'Gotham'
   @incomp   = 'gothamonfox'
   @comp_url = 'https://www.youtube.com/user/GothamFOX'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thegoodwife
   @compname = 'The Good Wife'
   @comp     = 'TheGoodWife_CBS'
   @incomp   = 'thegoodwife_cbs'
   @comp_url = 'https://www.youtube.com/user/thegoodwife'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thebigbangtheory
   @compname = 'The Big Bang Theory'
   @comp     = 'BigBang_CBS'
   @incomp   = 'bigbangtheory_cbs'
   @comp_url = 'https://www.youtube.com/user/thebigbangtheory'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def theblacklist
   @compname = 'Blacklist'
   @comp     = 'NBCBlacklist'
   @incomp   = 'nbcblacklist'
   @comp_url = 'https://www.youtube.com/user/NBCBlacklist'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def howtogetawaywithmurder
   @compname = 'How To Get Away'
   @comp     = 'HowToGetAwayABC'
   @incomp   = 'howtogetawaywithmurder'
   @comp_url = 'https://www.youtube.com/channel/UC-GfszUQ-kV4iMmk5W67mAQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thevoice
   @compname = 'The Voice'
   @comp     = 'NBCTheVoice'
   @incomp   = 'nbcthevoice'
   @comp_url = 'https://www.youtube.com/user/NBCTheVoice'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bachelorette
   @compname = 'Bachelorette'
   @comp     = 'BacheloretteABC'
   @incomp   = 'bacheloretteabc'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def scandal
   @compname = 'Scandal'
   @comp     = 'ScandalABC'
   @incomp   = 'scandalabc'
   @comp_url = 'https://www.youtube.com/channel/UCeGLGp4pnTqL64jY3p0daXA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def downtonabbey
   @compname = 'Downton Abbey'
   @comp     = 'DowntonAbbey'
   @incomp   = 'downtonabbey_official'
   @comp_url = 'https://www.youtube.com/channel/UCSm1kNzkDuHqirriGJMZHJQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def dancingwiththestars
   @compname = 'Dancing With The Stars'
   @comp     = 'DancingABC'
   @incomp   = 'dancingabc'
   @comp_url = 'https://www.youtube.com/user/ABCDWTS'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def americanidol
   @compname = 'American Idol'
   @comp     = 'AmericanIdol'
   @incomp   = 'americanidol'
   @comp_url = 'https://www.youtube.com/user/americanidol'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thementalist
   @compname = 'Mentalist'
   @comp     = 'Mentalist_CBS'
   @incomp   = 'mentalist_cbs'
   @comp_url = 'https://www.youtube.com/user/CBSTheMentalist'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def houseofcards
   @compname = 'House of Cards'
   @comp     = 'HouseofCards'
   @incomp   = 'houseofcards'
   @comp_url = 'https://www.youtube.com/channel/UCos_6s_sPNVZMA2YHeJ7nHg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def transparent
   @compname = 'Transparent'
   @comp     = 'transparent_tv'
   @incomp   = 'transparentamazon'
   @comp_url = 'https://www.youtube.com/channel/UCDHUIuNK2PG9UqXsxoLJxsw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def louie
   @compname = 'Louie'
   @comp     = 'LouieFX'
   @incomp   = 'louieonfx'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def community
   @compname = 'Community'
   @comp     = 'CommunityTV'
   @incomp   = 'communitytv'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def parksandrecreation
   @compname = 'Parks and Recreation'
   @comp     = 'parksandrecnbc'
   @incomp   = 'nbcparksandrec'
   @comp_url = 'https://www.youtube.com/user/nbcParksandRec'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sonsofanarchy
   @compname = 'Sons of Anarchy'
   @comp     = 'SonsofAnarchy'
   @incomp   = 'soafx'
   @comp_url = 'https://www.youtube.com/channel/UCp-omzXg5JOqQJQErHhUhrw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def brooklynninenine
   @compname = 'Brooklyn 9-9'
   @comp     = 'Brooklyn99FOX'
   @incomp   = 'brooklyn99fox'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def fargo
   @compname = 'Fargo'
   @comp     = 'FargoFX'
   @incomp   = 'fargo'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def saturdaynightlive
   @compname = 'Saturday Night Live'
   @comp     = 'nbcsnl'
   @incomp   = 'nbcsnl'
   @comp_url = 'https://www.youtube.com/user/SaturdayNightLive'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def mrrobot
   @compname = 'Mr. Robot'
   @comp     = 'whoismrrobot'
   @incomp   = 'whoismrrobot'
   @comp_url = 'https://www.youtube.com/channel/UCX5R2xqZWND8nJqGTvel3nw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def themindyproject
   @compname = 'The Mindy Project'
   @comp     = 'TheMindyProject'
   @incomp   = 'mindyprojecthulu'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newgirl
   @compname = 'New Girl'
   @comp     = 'NewGirlonFOX'
   @incomp   = 'newgirlfox'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def scorpion
   @compname = 'Scorpion'
   @comp     = 'ScorpionCBS'
   @incomp   = 'scorpioncbs'
   @comp_url = 'https://www.youtube.com/user/CBSScorpion'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def modernfamily
   @compname = 'Modern Family'
   @comp     = 'ModernFam'
   @incomp   = 'modernfamily'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def janethevirgin
   @compname = 'Jane The Virgin'
   @comp     = 'CWJaneTheVirgin'
   @incomp   = 'cwjanethevirgin'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

#####SPORTS

  def realmadrid
   @compname = 'Real Madrid'
   @comp     = 'realmadrid'
   @incomp   = 'realmadrid'
   @comp_url = 'https://www.youtube.com/user/realmadridcf'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def dallascowboys
   @compname = 'Dallas Cowboys'
   @comp     = 'dallascowboys'
   @incomp   = 'dallascowboys'
   @comp_url = 'https://www.youtube.com/channel/UCdjR8pv3bU7WLRshUMwxDVw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newyorkyankees
   @compname = 'New York Yankees'
   @comp     = 'Yankees'
   @incomp   = 'yankees'
   @comp_url = 'https://www.youtube.com/channel/UCQNgE6-Q5OBvLzhyAmWZItQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def barcelona
   @compname = 'Barcelona'
   @comp     = 'FCBarcelona'
   @incomp   = 'fcbarcelona'
   @comp_url = 'https://www.youtube.com/user/fcbarcelona'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def manchesterunited
   @compname = 'Manchester United'
   @comp     = 'ManUtd'
   @incomp   = 'manchesterunited'
   @comp_url = 'https://www.youtube.com/channel/UCKHRBMEiy-GuV-F7JQbJWLg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def losangeleslakers
   @compname = 'Los Angeles Lakers'
   @comp     = 'Lakers'
   @incomp   = 'lakers'
   @comp_url = 'https://www.youtube.com/user/lakersnationdotcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newenglandpatriots
   @compname = 'New England Patriots'
   @comp     = 'Patriots'
   @incomp   = 'patriots'
   @comp_url = 'https://www.youtube.com/channel/UCF54f0UTZ2ctCDs5yJjDblQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newyorkknicks
   @compname = 'New York Knicks'
   @comp     = 'nyknicks'
   @incomp   = 'nyknicks'
   @comp_url = 'https://www.youtube.com/user/nyknicks'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def losangelesdodgers
   @compname = 'Los Angeles Dodgers'
   @comp     = 'Dodgers'
   @incomp   = 'dodgers'
   @comp_url = 'https://www.youtube.com/channel/UCg_8DdhmyMMxa8Xwbcmm-_w'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def washingtonredskins
   @compname = 'Washington Redskins'
   @comp     = 'Redskins'
   @incomp   = 'redskins'
   @comp_url = 'https://www.youtube.com/user/redskinsdotcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bayernmunich
   @compname = 'Bayern Munich'
   @comp     = 'FCBayern'
   @incomp   = 'fcbayern'
   @comp_url = 'https://www.youtube.com/user/fcbayern'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bostonredsox
   @compname = 'Boston Red Sox'
   @comp     = 'RedSox'
   @incomp   = 'redsox'
   @comp_url = 'https://www.youtube.com/channel/UC3FcTH3wcqNWHx4T6iICz_g'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newyorkgiants
   @compname = 'New York Giants'
   @comp     = 'Giants'
   @incomp   = 'nygiants'
   @comp_url = 'https://www.youtube.com/channel/UCnEubDTRusG-qvohSNyCuWg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def chicagobulls
   @compname = 'Chicago Bulls'
   @comp     = 'chicagobulls'
   @incomp   = 'chicagobulls'
   @comp_url = 'https://www.youtube.com/user/chicagobullsofficial'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sanfranciscogiants
   @compname = 'San Francisco Giants'
   @comp     = 'SFGiants'
   @incomp   = 'sfgiants'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def houstontexans
   @compname = 'Houston Texans'
   @comp     = 'HoustonTexans'
   @incomp   = 'houstontexans'
   @comp_url = 'https://www.youtube.com/channel/UC3fjWR24Ej6EfvMv6Hqq28g'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def chicagocubs
   @compname = 'Chicago Cubs'
   @comp     = 'Cubs'
   @incomp   = 'cubs'
   @comp_url = 'https://www.youtube.com/channel/UCbtkUT23QOxQb1w1aP-tRIA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newyorkjets
   @compname = 'New York Jets'
   @comp     = 'nyjets'
   @incomp   = 'nyjets'
   @comp_url = 'https://www.youtube.com/channel/UCNdo59IgJRskCLP7FBWqe6w'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def philadelphiaeagles
   @compname = 'Philadelphia Eagles'
   @comp     = 'Eagles'
   @incomp   = 'philadelphiaeagles'
   @comp_url = 'https://www.youtube.com/channel/UCaogx6OHpsGg0zuGRKsjbtQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bostonceltics
   @compname = 'Boston Celtics'
   @comp     = 'celtics'
   @incomp   = 'celtics'
   @comp_url = 'https://www.youtube.com/user/bostonceltics'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def chicagobears
   @compname = 'Chicago Bears'
   @comp     = 'ChicagoBears'
   @incomp   = 'chicagobears'
   @comp_url = 'https://www.youtube.com/channel/UCP0Cdc6moLMyDJiO0s-yhbQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def losangelesclippers
   @compname = 'Los Angeles Clippers'
   @comp     = 'LAClippers'
   @incomp   = 'laclippers'
   @comp_url = 'https://www.youtube.com/user/clippers1970'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sanfrancisco49ers
   @compname = 'San Francisco 49ers'
   @comp     = '49ers'
   @incomp   = '49ers'
   @comp_url = 'https://www.youtube.com/user/sanfrancisco49ers'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def baltimoreravens
   @compname = 'Baltimore Ravens'
   @comp     = 'Ravens'
   @incomp   = 'ravens'
   @comp_url = 'https://www.youtube.com/user/baltimoreravens'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def brooklynnets
   @compname = 'Brooklyn Nets'
   @comp     = 'BrooklynNets'
   @incomp   = 'brooklynnets'
   @comp_url = 'https://www.youtube.com/user/NBANets'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def denverbroncos
   @compname = 'Denver Broncos'
   @comp     = 'Broncos'
   @incomp   = 'broncos'
   @comp_url = 'https://www.youtube.com/channel/UCe6XsNDeY3pxqXJMc_iheUA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def indianapoliscolts
   @compname = 'Indianapolis Colts'
   @comp     = 'Colts'
   @incomp   = 'colts'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def stlouiscardinals
   @compname = 'St. Louis Cardinals'
   @comp     = 'Cardinals'
   @incomp   = 'cardinals'
   @comp_url = 'https://www.youtube.com/channel/UCYPeuBXCeFOq5QfhEnUfr8A'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def greenbaypackers
   @compname = 'Greenbay Packers'
   @comp     = 'packers'
   @incomp   = 'packers'
   @comp_url = 'https://www.youtube.com/channel/UC_C4jeUvhqbsOFCCMql5sHg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def chelsea
   @compname = 'Chelsea'
   @comp     = 'ChelseaFC'
   @incomp   = 'chelseafc'
   @comp_url = 'https://www.youtube.com/user/chelseafc'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ferrari
   @compname = 'Ferrari'
   @comp     = 'Ferrari'
   @incomp   = 'ferrariusa'
   @comp_url = 'https://www.youtube.com/user/ferrariworld'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def newyorkmets
   @compname = 'New York Mets'
   @comp     = 'Mets'
   @incomp   = 'mets'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def pittsburghsteelers
   @compname = 'Pittsburgh Steelers'
   @comp     = 'steelers'
   @incomp   = 'steelers'
   @comp_url = 'https://www.youtube.com/channel/UCR6rBAe6fuKAJjdg4dbAcqg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def seattleseahawks
   @compname = 'Seattle Seahawks'
   @comp     = 'Seahawks'
   @incomp   = 'seahawks'
   @comp_url = 'https://www.youtube.com/user/seahawksdotcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def arsenal
   @compname = 'Arsenal'
   @comp     = 'Arsenal'
   @incomp   = 'arsenal'
   @comp_url = 'https://www.youtube.com/user/ArsenalTour'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def goldenstatewarriors
   @compname = 'Golden State Warriors'
   @comp     = 'warriors'
   @incomp   = 'warriors'
   @comp_url = 'https://www.youtube.com/user/GoldenStateWarriors'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def losangelesangelsofanaheim
   @compname = 'Angels of Anaheim'
   @comp     = 'Angels'
   @incomp   = 'angels'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def miamidolphins
   @compname = 'Miami Dolphins'
   @comp     = 'MiamiDolphins'
   @incomp   = 'miamidolphins'
   @comp_url = 'https://www.youtube.com/channel/UCdbljRu3B3WIYliBJat_wsg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def torontomapleleafs
   @compname = 'Toronto Maple Leafs'
   @comp     = 'MapleLeafs'
   @incomp   = 'mapleleafs'
   @comp_url = 'https://www.youtube.com/user/torontomapleleafs'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def washingtonnationals
   @compname = 'Washington Nationals'
   @comp     = 'Nationals'
   @incomp   = 'nationals'
   @comp_url = 'https://www.youtube.com/channel/UCQh28Q2ew4jVoNcDyRygeBw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def carolinapanthers
   @compname = 'Carolina Panthers'
   @comp     = 'Panthers'
   @incomp   = 'panthers'
   @comp_url = 'https://www.youtube.com/channel/UCDmv5BcYE3hQW354jk9W0Cg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def houstonrockets
   @compname = 'Houston Rockets'
   @comp     = 'HoustonRockets'
   @incomp   = 'houstonrockets'
   @comp_url = 'https://www.youtube.com/channel/UCmjAHvW8SC7vmhCFomfyV7Q'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def philadelphiaphillies
   @compname = 'Philadelphia Phillies'
   @comp     = 'Phillies'
   @incomp   = 'phillies'
   @comp_url = 'https://www.youtube.com/channel/UCQh91_NPlNSpWWfqcVLUMTQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tampabaybuccaneers
   @compname = 'Tampa Bay Buccaneers'
   @comp     = 'TBBuccaneers'
   @incomp   = 'tbbuccaneers'
   @comp_url = 'https://www.youtube.com/channel/UC_DXo-lcvFwMWCYNgHP4_tg'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def texasrangers
   @compname = 'Texas Rangers'
   @comp     = 'Rangers'
   @incomp   = 'rangers'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def miamiheat
   @compname = 'Miami Heat'
   @comp     = 'MiamiHEAT'
   @incomp   = 'miamiheat'
   @comp_url = 'https://www.youtube.com/user/miamiheat'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tennesseetitans
   @compname = 'Tennessee Titans'
   @comp     = 'Titans'
   @incomp   = 'tennesseetitans'
   @comp_url = 'https://www.youtube.com/channel/UCZIg4NlOuW_ReCVVZ64eLlw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def atlantabraves
   @compname = 'Atlanta Braves'
   @comp     = 'Braves'
   @incomp   = 'braves'
   @comp_url = 'https://www.youtube.com/channel/UCglKlWno0PXtVhWWQLyQyPQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def minnesotavikings
   @compname = 'Minnesota Vikings'
   @comp     = 'Vikings'
   @incomp   = 'vikings'
   @comp_url = 'https://www.youtube.com/channel/UCSb9A1uBRGUHfSyKCrhfXYA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def arizonacardinals
   @compname = 'Arizona Cardinals'
   @comp     = 'AZCardinals'
   @incomp   = 'azcardinals'
   @comp_url = 'https://www.youtube.com/channel/UC9YrTlASDs12N2SosBvl8tQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def manchestercity
   @compname = 'Manchester City'
   @comp     = 'MCFC'
   @incomp   = 'mcfcofficial'
   @comp_url = 'https://www.youtube.com/user/mcfcofficial'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def onedirection
   @compname = 'One Direction'
   @comp     = 'onedirection'
   @incomp   = 'onedirection'
   @comp_url = 'https://www.youtube.com/user/OneDirectionVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def katyperrymusic
   @compname = 'Katy Perry'
   @comp     = 'katyperry'
   @incomp   = 'katyperry'
   @comp_url = 'https://www.youtube.com/user/KatyPerryVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def beyoncemusic
   @compname = 'Beyonce'
   @comp     = 'Beyonce'
   @incomp   = 'beyonce'
   @comp_url = 'https://www.youtube.com/user/beyonceVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def taylorswiftmusic
   @compname = 'Taylor Swift'
   @comp     = 'taylorswift13'
   @incomp   = 'taylorswift'
   @comp_url = 'https://www.youtube.com/user/TaylorSwiftVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def justintimberlakemusic
   @compname = 'Justin Timberlake'
   @comp     = 'jtimberlake'
   @incomp   = 'justintimberlake'
   @comp_url = 'https://www.youtube.com/user/justintimberlakeVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def iggyazalea
   @compname = 'Iggy Azalea'
   @comp     = 'IGGYAZALEA'
   @incomp   = 'thenewclassic'
   @comp_url = 'https://www.youtube.com/user/iggyazaleamusicVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def arianagrandemusic
   @compname = 'Ariana Grande'
   @comp     = 'ArianaGrande'
   @incomp   = 'arianagrande'
   @comp_url = 'https://www.youtube.com/user/ArianaGrandeVevo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def mileycyrus
   @compname = 'Miley Cyrus'
   @comp     = 'MileyCyrus'
   @incomp   = 'mileycyrus'
   @comp_url = 'https://www.youtube.com/user/MileyCyrusVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def pharrelwilliams
   @compname = 'Pharrell Williams'
   @comp     = 'Pharrell'
   @incomp   = 'pharrell'
   @comp_url = 'https://www.youtube.com/user/PharrellWilliamsVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def eminem
   @compname = 'Eminem'
   @comp     = 'Eminem'
   @incomp   = 'eminem'
   @comp_url = 'https://www.youtube.com/user/EminemVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def lorde
   @compname = 'Lorde'
   @comp     = 'lordemusic'
   @incomp   = 'lordemusic'
   @comp_url = 'https://www.youtube.com/user/LordeVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def lukebryan
   @compname = 'Luke Bryan'
   @comp     = 'LukeBryanOnline'
   @incomp   = 'lukebryan'
   @comp_url = 'https://www.youtube.com/user/LukeBryanVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def samsmith
   @compname = 'Sam Smith'
   @comp     = 'samsmithworld'
   @incomp   = 'samsmithworld'
   @comp_url = 'https://www.youtube.com/user/SamSmithWorldVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def johnlegend
   @compname = 'John Legend'
   @comp     = 'johnlegend'
   @incomp   = 'johnlegend'
   @comp_url = 'https://www.youtube.com/user/johnlegendVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def onerepublic
   @compname = 'One Republic'
   @comp     = 'OneRepublic'
   @incomp   = 'onerepublic'
   @comp_url = 'https://www.youtube.com/user/OneRepublicVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def drake
   @compname = 'Drake'
   @comp     = 'Drake'
   @incomp   = 'leaderofnewschool'
   @comp_url = 'https://www.youtube.com/user/DrakeVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jasonderulo
   @compname = 'Jason Derulo'
   @comp     = 'jasonderulo'
   @incomp   = 'jasonderulo'
   @comp_url = 'https://www.youtube.com/user/JasonDerulo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def justinbieber
   @compname = 'Justin Bieber'
   @comp     = 'justinbieber'
   @incomp   = 'justinbieber'
   @comp_url = 'https://www.youtube.com/user/JustinBieberVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def imaginedragons
   @compname = 'Imagine Dragons'
   @comp     = 'imaginedragons'
   @incomp   = 'imaginedragons'
   @comp_url = 'https://www.youtube.com/user/ImagineDragonsVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def floridageorgialine
   @compname = 'Florida Georgia Line'
   @comp     = 'FLAGALine'
   @incomp   = 'flagaline'
   @comp_url = 'https://www.youtube.com/user/FlaGeorgiaLineVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nickiminajmusic
   @compname = 'Nicki Minaj'
   @comp     = 'NICKIMINAJ'
   @incomp   = 'nickiminaj'
   @comp_url = 'https://www.youtube.com/user/NickiMinajAtVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def secondsofsummer
   @compname = '5 Seconds of Summer'
   @comp     = '5SOS'
   @incomp   = '5sos'
   @comp_url = 'https://www.youtube.com/user/5sosvevo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ladygagamusic
   @compname = 'Lady Gaga'
   @comp     = 'ladygaga'
   @incomp   = 'ladygaga'
   @comp_url = 'https://www.youtube.com/user/LadyGagaVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def pitbull
   @compname = 'Pitbull'
   @comp     = 'pitbull'
   @incomp   = 'pitbull'
   @comp_url = 'https://www.youtube.com/user/PitbullVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def brunomarsmusic
   @compname = 'Bruno Mars'
   @comp     = 'BrunoMars'
   @incomp   = 'brunomars'
   @comp_url = 'https://www.youtube.com/user/ElektraRecords'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jasonaldean
   @compname = 'Jason Aldean'
   @comp     = 'Jason_Aldean'
   @incomp   = 'jasonaldean'
   @comp_url = 'https://www.youtube.com/user/Jason_Aldean'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def maroon5
   @compname = 'Maroon 5'
   @comp     = 'maroon5'
   @incomp   = 'maroon5'
   @comp_url = 'https://www.youtube.com/user/Maroon5VEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def chrisbrown
   @compname = 'Chris Brown'
   @comp     = 'chrisbrown'
   @incomp   = 'chrisbrownofficial'
   @comp_url = 'https://www.youtube.com/user/ChrisBrownVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def meghantrainor
   @compname = 'Meghan Trainor'
   @comp     = 'Meghan_Trainor'
   @incomp   = 'meghan_trainor'
   @comp_url = 'https://www.youtube.com/user/MeghanTrainorVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bastille
   @compname = 'Bastille'
   @comp     = 'bastilledan'
   @incomp   = 'bastilledan'
   @comp_url = 'https://www.youtube.com/user/BastilleVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def avicii
   @compname = 'Avicii'
   @comp     = 'Avicii'
   @incomp   = 'avicii'
   @comp_url = 'https://www.youtube.com/user/AviciiOfficialVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def magic
   @compname = 'Magic!'
   @comp     = 'ournameisMAGIC'
   @incomp   = 'ournameismagic'
   @comp_url = 'https://www.youtube.com/user/ournameismagicVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def demilovatomusic
   @compname = 'Demi Lovato'
   @comp     = 'ddlovato'
   @incomp   = 'ddlovato'
   @comp_url = 'https://www.youtube.com/user/DemiLovatoVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def blakeshelton
   @compname = 'Blake Shelton'
   @comp     = 'blakeshelton'
   @incomp   = 'blakeshelton'
   @comp_url = 'https://www.youtube.com/user/blakeshelton'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def coldplay
   @compname = 'Coldplay'
   @comp     = 'coldplay'
   @incomp   = 'coldplay'
   @comp_url = 'https://www.youtube.com/user/ColdplayVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def charlixcx
   @compname = 'Charli XCX'
   @comp     = 'charli_xcx'
   @incomp   = 'charli_xcx'
   @comp_url = 'https://www.youtube.com/user/officialcharlixcx'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nicoandvinz
   @compname = 'Nico & Vinz'
   @comp     = 'NicoandVinz'
   @incomp   = 'nicoandvinz'
   @comp_url = 'https://www.youtube.com/user/envymusicchannel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def therollingstones
   @compname = 'The Rolling Stones'
   @comp     = 'RollingStones'
   @incomp   = 'therollingstones'
   @comp_url = 'https://www.youtube.com/user/TheRollingStones'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def shakiramusic
   @compname = 'Shakira'
   @comp     = 'shakira'
   @incomp   = 'shakira'
   @comp_url = 'https://www.youtube.com/user/shakiraVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def passenger
   @compname = 'Passenger'
   @comp     = 'passengermusic'
   @incomp   = 'passengermusic'
   @comp_url = 'https://www.youtube.com/user/passengermusic'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def brantleygilbert
   @compname = 'Brantley Gilbert'
   @comp     = 'BrantleyGilbert'
   @incomp   = 'brantleygilbert'
   @comp_url = 'https://www.youtube.com/user/BrantleyGilbertVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def elliegoulding
   @compname = 'Ellie Goulding'
   @comp     = 'elliegoulding'
   @incomp   = 'elliegoulding'
   @comp_url = 'https://www.youtube.com/user/EllieGouldingVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ericchurch
   @compname = 'Eric Church'
   @comp     = 'ericchurch'
   @incomp   = 'ericchurchmusic'
   @comp_url = 'https://www.youtube.com/user/EricChurchVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def idinamenzel
   @compname = 'Idina Menzel'
   @comp     = 'idinamenzel'
   @incomp   = 'idinamenzel'
   @comp_url = 'https://www.youtube.com/user/Idinamenzel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def selenagomezmusic
   @compname = 'Selena Gomez'
   @comp     = 'selenagomez'
   @incomp   = 'selenagomez'
   @comp_url = 'https://www.youtube.com/user/SelenaGomezVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def calvinharris
   @compname = 'Calvin Harris'
   @comp     = 'CalvinHarris'
   @incomp   = 'calvinharris'
   @comp_url = 'https://www.youtube.com/user/CalvinHarrisVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def michaelbuble
   @compname = 'Michael Buble'
   @comp     = 'michaelbuble'
   @incomp   = 'michaelbuble'
   @comp_url = 'https://www.youtube.com/user/MichaelBubleTV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def michaeljackson
   @compname = 'Michael Jackson'
   @comp     = 'michaeljackson'
   @incomp   = 'michaeljackson'
   @comp_url = 'https://www.youtube.com/user/michaeljacksonVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def britneyspearsmusic
   @compname = 'Britney Spears'
   @comp     = 'britneyspears'
   @incomp   = 'britneyspears'
   @comp_url = 'https://www.youtube.com/user/BritneySpearsVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def kellyclarkson
   @compname = 'Kelly Clarkson'
   @comp     = 'kelly_clarkson'
   @incomp   = 'kellyclarkson'
   @comp_url = 'https://www.youtube.com/user/kellyclarksonVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def christinaaguileramusic
   @compname = 'Christinaa Guilera'
   @comp     = 'xtina'
   @incomp   = 'xtina'
   @comp_url = 'https://www.youtube.com/user/CAguileraVEVO'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  ####FOoD

  def allrecipes
   @compname = 'All Recipes'
   @comp     = 'Allrecipes'
   @incomp   = 'allrecipes'
   @comp_url = 'https://www.youtube.com/user/allrecipes'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def cookingdotcom
   @compname = 'Cooking.com'
   @comp     = 'CookingCom'
   @incomp   = 'cookingcom'
   @comp_url = 'https://www.youtube.com/user/cookingcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def foodnetwork
   @compname = 'Food Network'
   @comp     = 'FoodNetwork'
   @incomp   = 'foodnetwork'
   @comp_url = 'https://www.youtube.com/user/FoodNetworkTV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thekitchn
   @compname = 'The Kitchn'
   @comp     = 'thekitchn'
   @incomp   = 'thekitchn'
   @comp_url = 'https://www.youtube.com/channel/UCuNKgYLb0wOoMvclzSlBvbQ'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def opentable
   @compname = 'Open Table'
   @comp     = 'OpenTable'
   @incomp   = 'opentable'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tasteofhome
   @compname = 'Taste Of Home'
   @comp     = 'tasteofhome'
   @incomp   = 'tasteofhome'
   @comp_url = 'https://www.youtube.com/user/tasteofhome'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def epicurious
   @compname = 'Epicurious'
   @comp     = 'epicurious'
   @incomp   = 'epicurious'
   @comp_url = 'https://www.youtube.com/user/epicuriousdotcom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def grubhub
   @compname = 'Grub Hub'
   @comp     = 'GrubHub'
   @incomp   = 'grubhub'
   @comp_url = 'https://www.youtube.com/user/grubhub'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def seamless
   @compname = 'Seamless'
   @comp     = 'Seamless'
   @incomp   = 'eatseamless'
   @comp_url = 'https://www.youtube.com/user/eatseamless'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def yummly
   @compname = 'Yummly'
   @comp     = 'yummly'
   @incomp   = 'yummly'
   @comp_url = 'https://www.youtube.com/user/Yummly1'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def huffingtonpostfood
   @compname = 'Huffington Post Food'
   @comp     = 'HuffPostFood'
   @incomp   = 'huffpostfood'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def fooddotcom
   @compname = 'Food.com'
   @comp     = 'Fooddotcom'
   @incomp   = 'fooddotcom'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def bonappetit
   @compname = 'BonAppetit.com'
   @comp     = 'bonappetit'
   @incomp   = 'bonappetitmag'
   @comp_url = 'https://www.youtube.com/user/BonAppetitDotCom'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def weightwatchers
   @compname = 'Weight Watchers'
   @comp     = 'WeightWatchers'
   @incomp   = 'weightwatchers'
   @comp_url = 'https://www.youtube.com/user/WeightWatchers'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def foodandwine
   @compname = 'Food And Wine'
   @comp     = 'FoodAndWineMag'
   @incomp   = 'foodandwine'
   @comp_url = 'https://www.youtube.com/user/foodandwinevideo'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def thechew
   @compname = 'The Chew'
   @comp     = 'thechew'
   @incomp   = 'abcthechew'
   @comp_url = 'https://www.youtube.com/channel/UC-Hz_loYacm45SBtSVA0lRA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def americastestkitchen
   @compname = 'Americas Test Kitchen'
   @comp     = 'TestKitchen'
   @incomp   = 'testkitchen'
   @comp_url = 'https://www.youtube.com/user/americastestkitchen'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ironchefamerica
   @compname = 'Iron Chef America'
   @comp     = 'IronChefAmerica'
   @incomp   = 'ironchefamericacuisine'
   @comp_url = 'https://www.youtube.com/channel/UCoag6CfTHLeHuqtCpvo7o7Q'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  ######TRAVEL

  def drewbinsky
   @compname = 'Drew Binsky'
   @comp     = 'drewbinsky7'
   @incomp   = 'drewbinsky'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def budgettravel
   @compname = 'Budget Travel'
   @comp     = 'BudgetTravel'
   @incomp   = 'budgettravel'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def afar
   @compname = 'Afar'
   @comp     = 'AFARmedia'
   @incomp   = 'afarmedia'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def travelandleisure
   @compname = 'Travel and Leisure'
   @comp     = 'TravelLeisure'
   @incomp   = 'travelandleisure'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def condenasttraveler
   @compname = 'Condenast Traveler'
   @comp     = 'CNTraveler'
   @incomp   = 'cntraveler'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def geographical
   @compname = 'Geographical'
   @comp     = 'GeographicalMag'
   @incomp   = 'geographical_magazine'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nationalgeographic
   @compname = 'NatGeo'
   @comp     = 'NatGeo'
   @incomp   = 'natgeotravel'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def wanderlust
   @compname = 'Wanderlust'
   @comp     = 'WanderlustFest'
   @incomp   = 'wanderlustfest'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tyleroakley
   @compname = 'Tyler Oakley'
   @comp     = 'tyleroakley'
   @incomp   = 'tyleroakley'
   @comp_url = 'https://www.youtube.com/user/tyleroakley'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def troyesivan
   @compname = 'Troye Sivan'
   @comp     = 'troyesivan'
   @incomp   = 'troyesivan'
   @comp_url = 'https://www.youtube.com/user/TroyeSivan18'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def zoella
   @compname = 'Zoella'
   @comp     = 'ZoellaBeauty'
   @incomp   = 'zozeebo'
   @comp_url = 'https://www.youtube.com/user/zoella280390'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def connorfranta
   @compname = 'Connor Franta'
   @comp     = 'ConnorFranta'
   @incomp   = 'connorfranta'
   @comp_url = 'https://www.youtube.com/user/ConnorFranta'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ijustine
   @compname = 'I Justine'
   @comp     = 'ijustine'
   @incomp   = 'ijustine'
   @comp_url = 'https://www.youtube.com/user/ijustine'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def glozell
   @compname = 'GloZell'
   @comp     = 'GloZell'
   @incomp   = 'glozell'
   @comp_url = 'https://www.youtube.com/user/glozell1'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jennamarbles
   @compname = 'Jenna Marbles'
   @comp     = 'Jenna_Marbles'
   @incomp   = 'jennamarbles'
   @comp_url = 'https://www.youtube.com/user/JennaMarbles'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def alfiedeyes
   @compname = 'Alfie Deyes'
   @comp     = 'PointlessBlog'
   @incomp   = 'pointlessblog'
   @comp_url = 'https://www.youtube.com/user/PointlessBlog'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def shanedawson
   @compname = 'Shane Dawson'
   @comp     = 'shanedawson'
   @incomp   = 'shanedawson'
   @comp_url = 'https://www.youtube.com/user/shane'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def joeygraceffa
   @compname = 'Joey Graceffa'
   @comp     = 'JoeyGraceffa'
   @incomp   = 'joeygraceffa'
   @comp_url = 'https://www.youtube.com/user/JoeyGraceffa'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def rebeccablack
   @compname = 'Rebecca Black'
   @comp     = 'MsRebeccaBlack'
   @incomp   = 'justcallmerebecca'
   @comp_url = 'https://www.youtube.com/user/rebecca'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def pewdiepie
   @compname = 'PewDiePie'
   @comp     = 'pewdiepie'
   @incomp   = 'pewdiepie'
   @comp_url = 'https://www.youtube.com/user/PewDiePie'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def smosh
   @compname = 'Smosh'
   @comp     = 'smosh'
   @incomp   = 'smosh'
   @comp_url = 'https://www.youtube.com/user/smosh'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def nigahiga
   @compname = 'Niga Higa'
   @comp     = 'Niga_Higa'
   @incomp   = 'nigahiga_'
   @comp_url = 'https://www.youtube.com/user/nigahiga'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tobuscus
   @compname = 'Tobuscus'
   @comp     = 'Tobuscus'
   @incomp   = 'tobuscus'
   @comp_url = 'https://www.youtube.com/user/Tobuscus'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sawyerhartman
   @compname = 'Sawyer Hartman'
   @comp     = 'SawyerHartman'
   @incomp   = 'sawyerhartman'
   @comp_url = 'https://www.youtube.com/user/sawyerhartman'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def annoyingorange
   @compname = 'Annoying Orange'
   @comp     = 'annoyingorange'
   @incomp   = 'annoyingorange'
   @comp_url = 'https://www.youtube.com/user/realannoyingorange'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def rhettandlink
   @compname = 'Rhett and Link'
   @comp     = 'rhettandlink'
   @incomp   = 'rhettandlink'
   @comp_url = 'https://www.youtube.com/user/RhettandLink'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def itskingsleybitch
   @compname = 'ItsKingsleyBitch'
   @comp     = 'kingsleyyy'
   @incomp   = 'kingsleyyy'
   @comp_url = 'https://www.youtube.com/user/ItsKingsleyBitch'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def jimchapman
   @compname = 'Jim Chapman'
   @comp     = 'JimsTweetings'
   @incomp   = 'jimalfredchapman'
   @comp_url = 'https://www.youtube.com/user/j1mmyb0bba'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def danisnotonfire
   @compname = 'Dan Is Not On Fire'
   @comp     = 'danisnotonfire'
   @incomp   = 'danisnotonfire'
   @comp_url = 'https://www.youtube.com/user/danisnotonfire'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def kickthepj
   @compname = 'KickThePj'
   @comp     = 'kickthepj'
   @incomp   = 'kickthepj'
   @comp_url = 'https://www.youtube.com/user/KickThePj'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def catrific
   @compname = 'Catrific'
   @comp     = 'catrific'
   @incomp   = 'catrific'
   @comp_url = 'https://www.youtube.com/user/catrific'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tayzonday
   @compname = 'Tay Zonday'
   @comp     = 'TayZonday'
   @incomp   = 'tayzonday'
   @comp_url = 'https://www.youtube.com/user/TayZonday'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def marcusbutler
   @compname = 'Marcus Butler'
   @comp     = 'MarcusButler'
   @incomp   = 'marcusbutler'
   @comp_url = 'https://www.youtube.com/user/MarcusButlerTV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def benjamincook
   @compname = 'Benjamin Cook'
   @comp     = 'benjamin_cook'
   @incomp   = 'benjamin_cook'
   @comp_url = 'https://www.youtube.com/user/ninebrassmonkeys'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def olgakay
   @compname = 'Olga Kay'
   @comp     = 'OlgaKay'
   @incomp   = 'olgakay'
   @comp_url = 'https://www.youtube.com/user/olgakay'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def hannahhart
   @compname = 'Hannah Hart'
   @comp     = 'harto'
   @incomp   = 'harto'
   @comp_url = 'https://www.youtube.com/user/MyHarto'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def anthonypadilla
   @compname = 'Anthony Padilla'
   @comp     = 'smoshanthony'
   @incomp   = 'anthonypadilla'
   @comp_url = 'https://www.youtube.com/user/AnthonyPadilla'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def juliansmith
   @compname = 'Julian Smith'
   @comp     = 'JulianWasHere'
   @incomp   = 'julianwashere'
   @comp_url = 'https://www.youtube.com/user/juliansmith87'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def amazingphil
   @compname = 'Amazing Phil'
   @comp     = 'AmazingPhil'
   @incomp   = 'amazingphil'
   @comp_url = 'https://www.youtube.com/user/AmazingPhil'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def sampepper
   @compname = 'Sam Pepper'
   @comp     = 'sampepper'
   @incomp   = 'itssampepper'
   @comp_url = 'https://www.youtube.com/user/OFFICIALsampepper'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

####FASHION

  def armanifashion
   @compname = 'Armani'
   @comp     = 'armani'
   @incomp   = 'armani'
   @comp_url = 'https://www.youtube.com/user/Armani'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def burberryfashion
   @compname = 'Burberry'
   @comp     = 'Burberry'
   @incomp   = 'burberry'
   @comp_url = 'https://www.youtube.com/user/Burberry'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def calvinkleinfashion
   @compname = 'Calvin Klein'
   @comp     = 'CalvinKlein'
   @incomp   = 'calvinklein'
   @comp_url = 'https://www.youtube.com/user/calvinklein'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def chanel
   @compname = 'CHANEL'
   @comp     = 'CHANEL'
   @incomp   = 'chanelofficial'
   @comp_url = 'https://www.youtube.com/user/CHANEL'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def christiandior
   @compname = 'Dior'
   @comp     = 'Dior'
   @incomp   = 'dior'
   @comp_url = 'https://www.youtube.com/user/Dior'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def christianlouboutin
   @compname = 'Christian Louboutin'
   @comp     = 'LouboutinWorld'
   @incomp   = 'louboutinworld'
   @comp_url = 'https://www.youtube.com/user/christianlouboutin'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def dolceandgabbana
   @compname = 'Dolce and Gabbana'
   @comp     = 'dolcegabbana'
   @incomp   = 'dolcegabbana'
   @comp_url = 'https://www.youtube.com/user/dolcegabbanachannel'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def dkny
   @compname = 'DKNY'
   @comp     = 'dkny'
   @incomp   = 'dkny'
   @comp_url = 'https://www.youtube.com/user/dkny'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def escada
   @compname = 'Escada'
   @comp     = 'ESCADA'
   @incomp   = 'escadaofficial'
   @comp_url = 'https://www.youtube.com/user/Escadaeditor'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def fendi
   @compname = 'Fendi'
   @comp     = 'Fendi'
   @incomp   = 'fendi'
   @comp_url = 'https://www.youtube.com/user/FENDICHANNEL'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def guccifashion
   @compname = 'Gucci'
   @comp     = 'gucci'
   @incomp   = 'gucci'
   @comp_url = 'https://www.youtube.com/user/gucciofficial'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def prada
   @compname = 'Prada'
   @comp     = 'Prada'
   @incomp   = 'prada'
   @comp_url = 'https://www.youtube.com/user/PRADA'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def hugobossfashion
   @compname = 'Hugo Boss'
   @comp     = 'HUGOBOSS'
   @incomp   = 'hugoboss'
   @comp_url = 'https://www.youtube.com/user/HUGOBOSSTV'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def johnvarvatos
   @compname = 'John Varvatos'
   @comp     = 'johnvarvatos'
   @incomp   = 'johnvarvatos'
   @comp_url = 'https://www.youtube.com/user/johnvarvatos'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def laperlalingerie
   @compname = 'La Perla Lingerie'
   @comp     = 'LaPerlaLingerie'
   @incomp   = 'laperlalingerie'
   @comp_url = 'https://www.youtube.com/user/LaPerlaLingerie'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def louisvuitton
   @compname = 'Louis Vuitton'
   @comp     = 'LouisVuitton'
   @incomp   = 'louisvuitton'
   @comp_url = 'https://www.youtube.com/user/LOUISVUITTON'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def manoloblahnik
   @compname = 'Manolo Blahnik'
   @comp     = 'ManoloBlahnik'
   @incomp   = 'manoloblahnikhq'
   @comp_url = 'https://www.youtube.com/channel/UCBldabiGA8UYQQgbwyI-jyw'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def missoni
   @compname = 'Missoni'
   @comp     = 'Missoni'
   @incomp   = 'missoni'
   @comp_url = 'https://www.youtube.com/user/MissoniOfficial'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def ralphlaurenfashion
   @compname = 'Ralph Lauren'
   @comp     = 'RalphLauren'
   @incomp   = 'ralphlauren'
   @comp_url = 'https://www.youtube.com/user/RLTVralphlauren'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def rolandmouret
   @compname = 'Roland Mouret'
   @comp     = 'RolandMouret'
   @incomp   = 'roland_mouret'
   @comp_url = 'https://www.youtube.com/user/RolandMouretFilms'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def stellamccartney
   @compname = 'Stella McCartney'
   @comp     = 'StellaMcCartney'
   @incomp   = 'stellamccartney'
   @comp_url = 'https://www.youtube.com/user/stellamccartney1'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def tomford
   @compname = 'Tom Ford'
   @comp     = 'TOMFORD'
   @incomp   = 'tomford'
   @comp_url = 'https://www.youtube.com/user/TOMFORDINTERNATIONAL'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def versace
   @compname = 'Versace'
   @comp     = 'Versace'
   @incomp   = 'versace_official'
   @comp_url = 'https://www.youtube.com/user/VersaceVideos'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end

  def michaelkors
   @compname = 'Michael Kors'
   @comp     = 'MichaelKors'
   @incomp   = 'michaelkors'
   @comp_url = 'https://www.youtube.com/user/michaelkors'
   page     = Biz::Timeline.new(@comp, @comp_url, @incomp, @page)
   @timeline = page.construct(params).flatten.sort {|a, b| b.created_time <=> a.created_time}
   render 'comp'
  end
end
# #####FASHION



# armanifashion                Armani            armani            https://www.youtube.com/user/Armani
# burberryfashion              Burberry          burberry          https://www.youtube.com/user/Burberry
# calvinkleinfashion           CalvinKlein       calvinklein       https://www.youtube.com/user/calvinklein
# chanel                CHANEL            chanelofficial    https://www.youtube.com/user/CHANEL
# christiandior         Dior              dior              https://www.youtube.com/user/Dior

# christianlouboutin    LouboutinWorld    louboutinworld    https://www.youtube.com/user/christianlouboutin
# dolceandgabbana       dolcegabbana      dolcegabbana      https://www.youtube.com/user/dolcegabbanachannel
# dkny                  dkny              dkny              https://www.youtube.com/user/dkny
# escada                ESCADA            escadaofficial    https://www.youtube.com/user/Escadaeditor
# fendi                 Fendi             fendi             https://www.youtube.com/user/FENDICHANNEL

# gucci                 gucci             gucci             https://www.youtube.com/user/gucciofficial
# prada                 Prada             prada             https://www.youtube.com/user/PRADA
# hugobossfashion              HUGOBOSS          hugoboss          https://www.youtube.com/user/HUGOBOSSTV
# johnvarvatos          johnvarvatos      johnvarvatos      https://www.youtube.com/user/johnvarvatos
# laperlalingerie       LaPerlaLingerie   laperlalingerie   https://www.youtube.com/user/LaPerlaLingerie

# louisvuitton          LouisVuitton      louisvuitton      https://www.youtube.com/user/LOUISVUITTON
# manoloblahnik         ManoloBlahnik     manoloblahnikhq   https://www.youtube.com/channel/UCBldabiGA8UYQQgbwyI-jyw
# missoni               Missoni           missoni           https://www.youtube.com/user/MissoniOfficial
# ralphlaurenfashion           RalphLauren       ralphlauren       https://www.youtube.com/user/RLTVralphlauren
# rolandmouret          RolandMouret      roland_mouret     https://www.youtube.com/user/RolandMouretFilms

# stellamccartney       StellaMcCartney   stellamccartney   https://www.youtube.com/user/stellamccartney1
# tomford               TOMFORD           tomford           https://www.youtube.com/user/TOMFORDINTERNATIONAL
# versace               Versace           versace_official  https://www.youtube.com/user/VersaceVideos
# michaelkors           MichaelKors       michaelkors       https://www.youtube.com/user/michaelkors

###########YOUTUBER


# tyleroakley         tyleroakley       tyleroakley         https://www.youtube.com/user/tyleroakley
# troyesivan          troyesivan        troyesivan          https://www.youtube.com/user/TroyeSivan18
# zoella              ZoellaBeauty      zozeebo             https://www.youtube.com/user/zoella280390
# connorfranta        ConnorFranta      connorfranta        https://www.youtube.com/user/ConnorFranta
# ijustine            ijustine          ijustine            https://www.youtube.com/user/ijustine

# glozell             GloZell           glozell             https://www.youtube.com/user/glozell1
# jennamarbles        Jenna_Marbles     jennamarbles        https://www.youtube.com/user/JennaMarbles
# alfiedeyes          PointlessBlog     pointlessblog       https://www.youtube.com/user/PointlessBlog
# shanedawson         shanedawson       shanedawson         https://www.youtube.com/user/shane
# joeygraceffa        JoeyGraceffa      joeygraceffa        https://www.youtube.com/user/JoeyGraceffa

# rebeccablack        MsRebeccaBlack    justcallmerebecca   https://www.youtube.com/user/rebecca
# pewdiepie           pewdiepie         pewdiepie           https://www.youtube.com/user/PewDiePie
# smosh               smosh             smosh               https://www.youtube.com/user/smosh
# nigahiga            Niga_Higa         nigahiga_           https://www.youtube.com/user/nigahiga
# tobuscus            Tobuscus          tobuscus            https://www.youtube.com/user/Tobuscus

# sawyerhartman       SawyerHartman     sawyerhartman       https://www.youtube.com/user/sawyerhartman
# annoyingorange      annoyingorange    annoyingorange      https://www.youtube.com/user/realannoyingorange
# rhettandlink        rhettandlink      rhettandlink        https://www.youtube.com/user/RhettandLink
# itskingsleybitch    kingsleyyy        kingsleyyy          https://www.youtube.com/user/ItsKingsleyBitch
# jimchapman          JimsTweetings     jimalfredchapman    https://www.youtube.com/user/j1mmyb0bba

# danisnotonfire      danisnotonfire    danisnotonfire      https://www.youtube.com/user/danisnotonfire
# kickthepj           kickthepj         kickthepj           https://www.youtube.com/user/KickThePj
# catrific            catrific          catrific            https://www.youtube.com/user/catrific
# tayzonday           TayZonday         tayzonday           https://www.youtube.com/user/TayZonday
# marcusbutler        MarcusButler      marcusbutler        https://www.youtube.com/user/MarcusButlerTV

# benjamincook        benjamin_cook     benjamin_cook       https://www.youtube.com/user/ninebrassmonkeys
# olgakay             OlgaKay           olgakay             https://www.youtube.com/user/olgakay
# hannahhart          harto             harto               https://www.youtube.com/user/MyHarto
# anthonypadilla      smoshanthony      anthonypadilla      https://www.youtube.com/user/AnthonyPadilla
# juliansmith         JulianWasHere     julianwashere       https://www.youtube.com/user/juliansmith87

# amazingphil         AmazingPhil       amazingphil         https://www.youtube.com/user/AmazingPhil
# sampepper           sampepper         itssampepper        https://www.youtube.com/user/OFFICIALsampepper

####CELEBRITIES
# blakelively         blakelively         blakelively             https://www.youtube.com/channel/UCKMKpIg3ZXn-7_xr4RAuQjA
# leonardodicaprio    LeoDiCaprio         leonardodicaprio        https://www.youtube.com/channel/UCc5HhOHhTKOMK_ta2lqtKgw
# emmastone           EmmaStoneWeb        emmastone_official_     none
# jayz                JayZClassicBars     shawn.carter            https://www.youtube.com/user/JayZVEVO
# ellendegeneres      TheEllenShow        theellenshow            https://www.youtube.com/user/TheEllenShow

# sandrabullock       sbullockweb         sandrabullockig         none
# ashleygreene        AshleyMGreene       ashleygreene            https://www.youtube.com/channel/UCEHOQe7Kk_4F6LvAcPp1SKQ
# natalieportman      PortmanUpdate       natalieportmanlove      https://www.youtube.com/channel/UC7M0_DE8EhWTpSgRqiuToCA
# jenniferlawrence    MsJenniferLaw       jenniferlawrencepx      https://www.youtube.com/channel/UC1SBXt6T5VT12_UFUupLWXA
# katebosworth        katebosworth        katebosworth            https://www.youtube.com/channel/UC-jXKCYtzcMjBr8f66hyEvA

# camerondiaz         CameronDiaz         camerondiaz             https://www.youtube.com/channel/UC9k-NlU7gjr8F0HlCTAWlXQ
# milakunis           Milla_Kunis         milakunis______         https://www.youtube.com/channel/UCl6qhIrV6It5TCyjS6Cq2lg
# floydmayweather     FloydMayweather     floydmayweather         https://www.youtube.com/user/FloydMayweather
# reesewitherspoon    RWitherspoon        reesewitherspoon        https://www.youtube.com/channel/UCE20hbhrnFW3bhndXukSxAg
# kateupton           KateUpton           kateupton               https://www.youtube.com/channel/UCyXW3LwGzBo1gQ8DOg7L5Nw

# peterdinklage       Peter_Dinklage      peterdinklage           none





# katyperry           katyperry           katyperry               https://www.youtube.com/user/KatyPerryVEVO
# barackobama         BarackObama         barackobama             https://www.youtube.com/user/BarackObamadotcom
# taylorswift         taylorswift13       taylorswift             https://www.youtube.com/user/TaylorSwiftVEVO
# ladygaga            ladygaga            ladygaga                https://www.youtube.com/user/LadyGagaVEVO
# justintimberlake    jtimberlake         justintimberlake        https://www.youtube.com/user/justintimberlakeVEVO

# brittneyspears      britneyspears       britneyspears           https://www.youtube.com/user/BritneySpearsVEVO
# kimkardashianwest   KimKardashian       kimkardashian           none
# shakira             shakira             shakira                 https://www.youtube.com/user/shakiraVEVO
# jenniferlopez       JLo                 jlo                     https://www.youtube.com/user/JenniferLopez
# selenagomez         selenagomez         selenagomez             https://www.youtube.com/user/SelenaGomezVEVO

# arianagrande        ArianaGrande        arianagrande            https://www.youtube.com/user/ArianaGrandeVevo
# demilovato          ddlovato            ddlovato                https://www.youtube.com/user/DemiLovatoVEVO
# jimmyfallon         jimmyfallon         jimmyfallon             https://www.youtube.com/user/latenight
# lebronjames         KingJames           kingjames               none
# adele               OfficialAdele       adele                   https://www.youtube.com/user/AdeleVEVO

# brunomars           BrunoMars           brunomars               https://www.youtube.com/user/ElektraRecords
# aliciakeys          aliciakeys          aliciakeys              https://www.youtube.com/user/aliciakeysVEVO
# mileyraycyrus       MileyCyrus          mileycyrus              https://www.youtube.com/user/MileyCyrusVEVO
# nickiminaj          NICKIMINAJ          nickiminaj              https://www.youtube.com/user/NickiMinajAtVEVO
# emmawatson          EmWatson            emmawatson              none

# neilpatrickharris   ActuallyNPH         nph                     https://www.youtube.com/channel/UCk_Dx67t-aXqw9uQLVX-UCQ
# davidguetta         davidguetta         davidguetta             https://www.youtube.com/user/davidguettavevo
# conanobrien         ConanOBrien         teamcoco                https://www.youtube.com/user/teamcoco
# khloekardashian     KhloeKardashian     kloekardashianthegirl   https://www.youtube.com/channel/UCJy0RHFC64EC-kqWOfhCb_g
# kourtneykardashian  kourtneykardashian  kourtneykardash         https://www.youtube.com/channel/UCXIf9YuOaiCSn2r4P5SZ_Zw

# christinaaguilera   xtina               xtina                   https://www.youtube.com/user/CAguileraVEVO
# beyonce             Beyonce             beyonce                 https://www.youtube.com/user/beyonceVEVO
# oprahwinfrey        Oprah               oprah                   https://www.youtube.com/channel/UCqL0gza-KJcuVe3e0FCbM8Q
# johnnydepp          realdepp            johnnydepp.oficial      https://www.youtube.com/channel/UCPP2obRMCcnokAqR4NzMuwQ
# scarlettjohansson   ScarlettJOnline     scarlettjohanssonaddict https://www.youtube.com/channel/UCuaGAGmxgipdJEOrYaMT0Nw

# madonna             Madonna             madonna                 https://www.youtube.com/user/madonna
# tomhanks            tomhanks            tomhanks                https://www.youtube.com/user/tomhankschannel
# jessicaalba         jessicaalba         jessicaalba             https://www.youtube.com/channel/UCPJorwl_vxgiNni6Mas8a7A
# meganfox            meganfox            dailymeganfox           https://www.youtube.com/channel/UCsN68XRv5dVieQizOcLyzOg
# tigerwoods          TigerWoods          TigerWoods              none 


#####TV SHOWS

# lastweektonight                     LastWeekTonight     lastweektonight            https://www.youtube.com/user/LastWeekTonight
# gameofthrones                       GameOfThrones       gameofthrones              https://www.youtube.com/user/GameofThrones
# bettercallsaul                      BetterCallSaul      bettercallsaulamc          https://www.youtube.com/channel/UCCab9hOn5MELbKB__AOU3RQ
# orangeisthenewblack                 OITNB               oitnb                      none
# empire                              EmpireFox           empirefox                  https://www.youtube.com/user/EMPIREonFOX

# howimetyourmother                   OfficialHIMYM       himym_official             none
# madmen                              MadMen_AMC          madmen_amc                 none 
# theamericans                        TheAmericansFX      theamericansfx             https://www.youtube.com/user/TheAmericansFX
# thetonightshow                      FallonTonight       fallontonight              https://www.youtube.com/user/latenight
# truedetective                       TrueDetective       truedetective              none

# justified                           JustifiedFX         justifiedfx                none
# sense8                              sense8              sense8                     https://www.youtube.com/channel/UC7Vsk1omEqLSbxKdnSqYvXw
# izombie                             CWiZombie           thecwizombie               https://www.youtube.com/channel/UCtgIz5m-kWXdHOPYLp5Banw
# theflash                            CW_TheFlash         cwtheflash                 https://www.youtube.com/user/barryallentheflash1
# thebachelor                         BachelorABC         bachelorabc                https://www.youtube.com/channel/UCXyOZBTth57gdz6k7KPHOsw

# suits                               Suits_USA           suits_usa                  https://www.youtube.com/user/SuitsonUSA
# theellenshow                        TheEllenShow        theellenshow               https://www.youtube.com/user/TheEllenShow
# greysanatomy                        GreysABC            greysabc                   https://www.youtube.com/channel/UC5lWD_N9kq8IdWzLOdy5fow
# thewalkingdead                      WalkingDead_AMC     amcthewalkingdead          none
# americanhorrorstory                 AmericanHorrorStory americanhorrorstory        https://www.youtube.com/user/qwerty19107

# sharktank                           ABCSharkTank        sharktankabc               none
# gotham                              Gotham              gothamonfox                https://www.youtube.com/user/GothamFOX
# thegoodwife                         TheGoodWife_CBS     thegoodwife_cbs            https://www.youtube.com/user/thegoodwife
# thebigbangtheory                    BigBang_CBS         bigbangtheory_cbs          https://www.youtube.com/user/thebigbangtheory
# theblacklist                        NBCBlacklist        nbcblacklist               https://www.youtube.com/user/NBCBlacklist

# howtogetawaywithmurder              HowToGetAwayABC     howtogetawaywithmurder     https://www.youtube.com/channel/UC-GfszUQ-kV4iMmk5W67mAQ
# thevoice                            NBCTheVoice         nbcthevoice                https://www.youtube.com/user/NBCTheVoice
# bachelorette                        BacheloretteABC     bacheloretteabc            none
# scandal                             ScandalABC          scandalabc                 https://www.youtube.com/channel/UCeGLGp4pnTqL64jY3p0daXA
# downtonabbey                        DowntonAbbey        downtonabbey_official      https://www.youtube.com/channel/UCSm1kNzkDuHqirriGJMZHJQ

# dancingwiththestars                 DancingABC          dancingabc                 https://www.youtube.com/user/ABCDWTS
# americanidol                        AmericanIdol        americanidol               https://www.youtube.com/user/americanidol
# thementalist                        Mentalist_CBS       mentalist_cbs              https://www.youtube.com/user/CBSTheMentalist
# houseofcards                        HouseofCards        houseofcards               https://www.youtube.com/channel/UCos_6s_sPNVZMA2YHeJ7nHg
# transparent                         transparent_tv      transparentamazon          https://www.youtube.com/channel/UCDHUIuNK2PG9UqXsxoLJxsw

# louie                               LouieFX             louieonfx                  none
# community                           CommunityTV         communitytv                none
# parksandrecreation                  parksandrecnbc      nbcparksandrec             https://www.youtube.com/user/nbcParksandRec
# sonsofanarchy                       SonsofAnarchy       soafx                      https://www.youtube.com/channel/UCp-omzXg5JOqQJQErHhUhrw
# brooklynninenine                    Brooklyn99FOX       brooklyn99fox              none

# janethevirgin                       CWJaneTheVirgin     cwjanethevirgin            none
# fargo                               FargoFX             fargo                      none
# saturdaynightlive                   nbcsnl              nbcsnl                     https://www.youtube.com/user/SaturdayNightLive
# mrrobot                             whoismrrobot        whoismrrobot               https://www.youtube.com/channel/UCX5R2xqZWND8nJqGTvel3nw
# themindyproject                     TheMindyProject     mindyprojecthulu           none

# newgirl                             NewGirlonFOX        newgirlfox                 none 
# scorpion                            ScorpionCBS         scorpioncbs                https://www.youtube.com/user/CBSScorpion
# modernfamily                        ModernFam           modernfamily               none 

# #######Sports

# realmadrid                      realmadrid        realmadrid            https://www.youtube.com/user/realmadridcf
# dallascowboys                   dallascowboys     dallascowboys         https://www.youtube.com/channel/UCdjR8pv3bU7WLRshUMwxDVw
# newyorkyankees                  Yankees           yankees               https://www.youtube.com/channel/UCQNgE6-Q5OBvLzhyAmWZItQ
# barcelona                       FCBarcelona       fcbarcelona           https://www.youtube.com/user/fcbarcelona
# manchesterunited                ManUtd            manchesterunited      https://www.youtube.com/channel/UCKHRBMEiy-GuV-F7JQbJWLg

# losangeleslakers                Lakers            lakers                https://www.youtube.com/user/lakersnationdotcom
# newenglandpatriots              Patriots          patriots              https://www.youtube.com/channel/UCF54f0UTZ2ctCDs5yJjDblQ
# newyorkknicks                   nyknicks          nyknicks              https://www.youtube.com/user/nyknicks
# losangelesdodgers               Dodgers           dodgers               https://www.youtube.com/channel/UCg_8DdhmyMMxa8Xwbcmm-_w
# washingtonredskins              Redskins          redskins              https://www.youtube.com/user/redskinsdotcom

# bayernmunich                    FCBayern          fcbayern              https://www.youtube.com/user/fcbayern
# bostonredsox                    RedSox            redsox                https://www.youtube.com/channel/UC3FcTH3wcqNWHx4T6iICz_g
# newyorkgiants                   Giants            nygiants              https://www.youtube.com/channel/UCnEubDTRusG-qvohSNyCuWg
# chicagobulls                    chicagobulls      chicagobulls          https://www.youtube.com/user/chicagobullsofficial
# sanfranciscogiants              SFGiants          sfgiants              none

# houstontexans                   HoustonTexans     houstontexans         https://www.youtube.com/channel/UC3fjWR24Ej6EfvMv6Hqq28g
# chicagocubs                     Cubs              cubs                  https://www.youtube.com/channel/UCbtkUT23QOxQb1w1aP-tRIA
# newyorkjets                     nyjets            nyjets                https://www.youtube.com/channel/UCNdo59IgJRskCLP7FBWqe6w
# philadelphiaeagles              Eagles            philadelphiaeagles    https://www.youtube.com/channel/UCaogx6OHpsGg0zuGRKsjbtQ
# bostonceltics                   celtics           celtics               https://www.youtube.com/user/bostonceltics

# chicagobears                    ChicagoBears      chicagobears          https://www.youtube.com/channel/UCP0Cdc6moLMyDJiO0s-yhbQ
# losangelesclippers              LAClippers        laclippers            https://www.youtube.com/user/clippers1970
# sanfrancisco49ers               49ers             49ers                 https://www.youtube.com/user/sanfrancisco49ers
# baltimoreravens                 Ravens            ravens                https://www.youtube.com/user/baltimoreravens
# brooklynnets                    BrooklynNets      brooklynnets          https://www.youtube.com/user/NBANets

# denverbroncos                   Broncos           broncos               https://www.youtube.com/channel/UCe6XsNDeY3pxqXJMc_iheUA
# indianapoliscolts               Colts             colts                 none
# stlouiscardinals                Cardinals         cardinals             https://www.youtube.com/channel/UCYPeuBXCeFOq5QfhEnUfr8A
# greenbaypackers                 packers           packers               https://www.youtube.com/channel/UC_C4jeUvhqbsOFCCMql5sHg
# manchestercity                  MCFC              mcfcofficial          https://www.youtube.com/user/mcfcofficial

# chelsea                         ChelseaFC         chelseafc             https://www.youtube.com/user/chelseafc
# ferrari                         Ferrari           ferrariusa            https://www.youtube.com/user/ferrariworld
# newyorkmets                     Mets              mets                  none
# pittsburghsteelers              steelers          steelers              https://www.youtube.com/channel/UCR6rBAe6fuKAJjdg4dbAcqg
# seattleseahawks                 Seahawks          seahawks              https://www.youtube.com/user/seahawksdotcom

# arsenal                         Arsenal           arsenal               https://www.youtube.com/user/ArsenalTour
# goldenstatewarriors             warriors          warriors              https://www.youtube.com/user/GoldenStateWarriors
# losangelesangelsofanaheim       Angels            angels                none
# miamidolphins                   MiamiDolphins     miamidolphins         https://www.youtube.com/channel/UCdbljRu3B3WIYliBJat_wsg
# torontomapleleafs               MapleLeafs        mapleleafs            https://www.youtube.com/user/torontomapleleafs

# washingtonnationals             Nationals         nationals             https://www.youtube.com/channel/UCQh28Q2ew4jVoNcDyRygeBw
# carolinapanthers                Panthers          panthers              https://www.youtube.com/channel/UCDmv5BcYE3hQW354jk9W0Cg
# houstonrockets                  HoustonRockets    houstonrockets        https://www.youtube.com/channel/UCmjAHvW8SC7vmhCFomfyV7Q
# philadelphiaphillies            Phillies          phillies              https://www.youtube.com/channel/UCQh91_NPlNSpWWfqcVLUMTQ
# tampabaybuccaneers              TBBuccaneers      tbbuccaneers          https://www.youtube.com/channel/UC_DXo-lcvFwMWCYNgHP4_tg

# texasrangers                    Rangers           rangers               none
# miamiheat                       MiamiHEAT         miamiheat             https://www.youtube.com/user/miamiheat
# tennesseetitans                 Titans            tennesseetitans       https://www.youtube.com/channel/UCZIg4NlOuW_ReCVVZ64eLlw
# atlantabraves                   Braves            braves                https://www.youtube.com/channel/UCglKlWno0PXtVhWWQLyQyPQ
# minnesotavikings                Vikings           vikings               https://www.youtube.com/channel/UCSb9A1uBRGUHfSyKCrhfXYA

# arizonacardinals                AZCardinals       azcardinals           https://www.youtube.com/channel/UC9YrTlASDs12N2SosBvl8tQ

# ####MUSIC

# onedirection            onedirection        onedirection          https://www.youtube.com/user/OneDirectionVEVO
# katyperrymusic               katyperry           katyperry             https://www.youtube.com/user/KatyPerryVEVO
# beyoncemusic                 Beyonce             beyonce               https://www.youtube.com/user/beyonceVEVO
# taylorswiftmusic             taylorswift13       taylorswift           https://www.youtube.com/user/TaylorSwiftVEVO
# justintimberlakemusic        jtimberlake         justintimberlake      https://www.youtube.com/user/justintimberlakeVEVO

# iggyazalea              IGGYAZALEA          thenewclassic         https://www.youtube.com/user/iggyazaleamusicVEVO
# arianagrandemusic            ArianaGrande        arianagrande          https://www.youtube.com/user/ArianaGrandeVevo
# mileycyrus                   MileyCyrus          mileycyrus            https://www.youtube.com/user/MileyCyrusVEVO
# pharrelwilliams         Pharrell            pharrell              https://www.youtube.com/user/PharrellWilliamsVEVO
# eminem                  Eminem              eminem                https://www.youtube.com/user/EminemVEVO

# lorde                   lordemusic          lordemusic            https://www.youtube.com/user/LordeVEVO
# lukebryan               LukeBryanOnline     lukebryan             https://www.youtube.com/user/LukeBryanVEVO
# samsmith                samsmithworld       samsmithworld         https://www.youtube.com/user/SamSmithWorldVEVO
# johnlegend              johnlegend          johnlegend            https://www.youtube.com/user/johnlegendVEVO
# onerepublic             OneRepublic         onerepublic           https://www.youtube.com/user/OneRepublicVEVO

# drake                   Drake               leaderofnewschool     https://www.youtube.com/user/DrakeVEVO
# jasonderulo             jasonderulo         jasonderulo           https://www.youtube.com/user/JasonDerulo
# justinbieber            justinbieber        justinbieber          https://www.youtube.com/user/JustinBieberVEVO
# imaginedragons          imaginedragons      imaginedragons        https://www.youtube.com/user/ImagineDragonsVEVO
# floridageorgialine      FLAGALine           flagaline             https://www.youtube.com/user/FlaGeorgiaLineVEVO

# nickiminajmusic              NICKIMINAJ          nickiminaj            https://www.youtube.com/user/NickiMinajAtVEVO
# 5secondsofsummer        5SOS                5sos                  https://www.youtube.com/user/5sosvevo
# ladygagamusic                ladygaga            ladygaga              https://www.youtube.com/user/LadyGagaVEVO
# pitbull                 pitbull             pitbull               https://www.youtube.com/user/PitbullVEVO
# brunomarsmusic               BrunoMars           brunomars             https://www.youtube.com/user/ElektraRecords

# jasonaldean             Jason_Aldean        jasonaldean           https://www.youtube.com/user/Jason_Aldean
# maroon5                 maroon5             maroon5               https://www.youtube.com/user/Maroon5VEVO
# chrisbrown              chrisbrown          chrisbrownofficial    https://www.youtube.com/user/ChrisBrownVEVO
# meghantrainor           Meghan_Trainor      meghan_trainor        https://www.youtube.com/user/MeghanTrainorVEVO
# bastille                bastilledan         bastilledan           https://www.youtube.com/user/BastilleVEVO

# avicii                  Avicii              avicii                https://www.youtube.com/user/AviciiOfficialVEVO
# magic                   ournameisMAGIC      ournameismagic        https://www.youtube.com/user/ournameismagicVEVO
# demilovatomusic              ddlovato            ddlovato              https://www.youtube.com/user/DemiLovatoVEVO
# blakeshelton            blakeshelton        blakeshelton          https://www.youtube.com/user/blakeshelton
# coldplay                coldplay            coldplay              https://www.youtube.com/user/ColdplayVEVO

# charlixcx               charli_xcx          charli_xcx            https://www.youtube.com/user/officialcharlixcx
# nicoandvinz             NicoandVinz         nicoandvinz           https://www.youtube.com/user/envymusicchannel
# therollingstones        RollingStones       therollingstones      https://www.youtube.com/user/TheRollingStones
# shakiramusic                 shakira             shakira               https://www.youtube.com/user/shakiraVEVO
# passenger               passengermusic      passengermusic        https://www.youtube.com/user/passengermusic

# brantleygilbert         BrantleyGilbert     brantleygilbert       https://www.youtube.com/user/BrantleyGilbertVEVO
# elliegoulding           elliegoulding       elliegoulding         https://www.youtube.com/user/EllieGouldingVEVO
# ericchurch              ericchurch          ericchurchmusic       https://www.youtube.com/user/EricChurchVEVO
# idinamenzel             idinamenzel         idinamenzel           https://www.youtube.com/user/Idinamenzel
# selenagomezmusic             selenagomez         selenagomez           https://www.youtube.com/user/SelenaGomezVEVO

# calvinharris            CalvinHarris        calvinharris          https://www.youtube.com/user/CalvinHarrisVEVO
# michaelbuble            michaelbuble        michaelbuble          https://www.youtube.com/user/MichaelBubleTV
# michaeljackson          michaeljackson      michaeljackson        https://www.youtube.com/user/michaeljacksonVEVO
# britneyspearsmusic           britneyspears       britneyspears         https://www.youtube.com/user/BritneySpearsVEVO
# kellyclarkson           kelly_clarkson      kellyclarkson         https://www.youtube.com/user/kellyclarksonVEVO

# christinaaguileramusic       xtina               xtina                 https://www.youtube.com/user/CAguileraVEVO

# #####Food

# allrecipes              Allrecipes      allrecipes                https://www.youtube.com/user/allrecipes
# cookingdotcom           CookingCom      cookingcom                https://www.youtube.com/user/cookingcom
# foodnetwork             FoodNetwork     foodnetwork               https://www.youtube.com/user/FoodNetworkTV
# thekitchn               thekitchn       thekitchn                 https://www.youtube.com/channel/UCuNKgYLb0wOoMvclzSlBvbQ
# opentable               OpenTable       opentable                 None

# tasteofhome             tasteofhome     tasteofhome               https://www.youtube.com/user/tasteofhome
# epicurious              epicurious      epicurious                https://www.youtube.com/user/epicuriousdotcom
# grubhub                 GrubHub         grubhub                   https://www.youtube.com/user/grubhub
# seamless                Seamless        eatseamless               https://www.youtube.com/user/eatseamless
# yummly                  yummly          yummly                    https://www.youtube.com/user/Yummly1

# huffingtonpostfood      HuffPostFood    huffpostfood              None
# fooddotcom              Fooddotcom      fooddotcom                None
# bonappetit              bonappetit      bonappetitmag             https://www.youtube.com/user/BonAppetitDotCom
# weightwatchers          WeightWatchers  weightwatchers            https://www.youtube.com/user/WeightWatchers
# foodandwine             FoodAndWineMag  foodandwine               https://www.youtube.com/user/foodandwinevideo

# thechew                 thechew         abcthechew                https://www.youtube.com/channel/UC-Hz_loYacm45SBtSVA0lRA
# americastestkitchen     TestKitchen     testkitchen               https://www.youtube.com/user/americastestkitchen
# ironchefamerica         IronChefAmerica ironchefamericacuisine    https://www.youtube.com/channel/UCoag6CfTHLeHuqtCpvo7o7Q

# Diners, Drive-ins and Dives       
# Cake Boss       
# Cupcake Wars        
# Come Dine Witth Me        
# Cutthroat Kitchen       
# Bizarre Foods       
# Hells Kitchen        
# Chopped       
# Top Chef        
# The Rachael Ray Show        
# Kitchen Nightmares        
# Bar Rescue        


# ####TRAVEL

# budgettravel          BudgetTravel    budgettravel            None
# afar                  AFARmedia       afarmedia               None
# travelandleisure      TravelLeisure   travelandleisure        None
# condenasttraveler     CNTraveler      cntraveler              None
# geographical          GeographicalMag geographical_magazine   None

# nationalgeographic    NatGeo          natgeotravel            None
# wanderlust            WanderlustFest  wanderlustfest          None

# Cruise Travel       
# Cruising World        
# Coastal Living        
# Caribbean Living        
# Yachting        
# Destinations        
# Pathfinders Travel        
# Africa Geographic       
# Backpacker        
# Outside       
# Camping Life        
# Cabin Life        
# American Road       
# Trailer Life        
# Outpost Magazine        
# The Expeditioner        
# Suitcase  