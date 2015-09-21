class PagesController < ApplicationController

  def home
    if signed_in?
      @providers = Providers.for(current_user)
      @timeline  = timeline[:timeline].flatten.sort {|a, b|  b.created_time <=> a.created_time }
      # We need to do something with this
      # because if each user's details is needed.
      # only the last user's data is saved to this loop.
      # hence why i put #first at the end of the hash.

      @unauthed_accounts              = timeline[:unauthed_accounts].first
    end
    # render 'home' is implicit.
  end

  private

    def timeline(user=current_user)
      stack = {
        timeline: [],
        unauthed_accounts: [],
        feed_unauthed_accounts: []
      }
      current_user.followed_users.each do |user|
        feed=Feed.new(user)
        stack[:timeline] << feed.construct(params)
        # this is constantly getting over written for each user.
        stack[:feed_unauthed_accounts] << feed.unauthed_accounts
      end
      stack
    end
  public

  def help; end
  def about; end
  def feedback; end
  def qanda; end
  def terms; end
  def privacy; end
  def notifications; end

  def wired
   @compname = 'Wired'
   @comp     = 'wired'
   @comp_url = 'https://www.youtube.com/user/wired'
   @incomp   = 'wired'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def national_geographic
   @compname = 'NatGeo'
   @comp     = 'NatGeo'
   @comp_url = 'https://www.youtube.com/user/NationalGeographic'
   @incomp   = 'natgeo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def people_magazine
   @compname = 'People'
   @comp     = 'people'
   @comp_url = 'https://www.youtube.com/user/people'
   @incomp   = 'peoplemag'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def time_magazine
   @compname = 'Time'
   @comp     = 'TIME'
   @comp_url = 'https://www.youtube.com/user/TimeMagazine'
   @incomp   = 'time'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sports_illustrated
   @compname = 'Sports Illustrated'
   @comp     = 'sinow'
   @comp_url = 'https://www.youtube.com/user/SportsIllustrated'
   @incomp   = 'sportsillustrated'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cosmopolitan
   @compname = 'Cosmopolitan'
   @comp     = 'Cosmopolitan'
   @comp_url = 'https://www.youtube.com/user/HelloStyleChannel'
   @incomp   = 'cosmopolitan'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def redbull
   @compname = 'Redbull'
   @comp     = 'redbull'
   @comp_url = 'https://www.youtube.com/user/redbull'
   @incomp   = 'redbull'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def espn
   @compname = 'ESPN'
   @comp     = 'espn'
   @comp_url = 'https://www.youtube.com/user/ESPN'
   @incomp   = 'espn'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def us_weekly
   @compname = 'US Weekly'
   @comp     = 'usweekly'
   @comp_url = 'https://www.youtube.com/user/UsWeekly'
   @incomp   = 'usweekly'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def entertainment_weekly
   @compname = 'Entertainment'
   @comp     = 'EW'
   @comp_url = 'https://www.youtube.com/user/ew'
   @incomp   = 'entertainmentweekly'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newsweek
   @compname = 'Newsweek'
   @comp     = 'Newsweek'
   @comp_url = 'https://www.youtube.com/user/NewsweekVideo'
   @incomp   = 'newsweek'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def popular_science
   @compname = 'PopSci'
   @comp     = 'PopSci'
   @comp_url = 'https://www.youtube.com/user/Popscivideo'
   @incomp   = 'popsci'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def vogue
   @compname = 'Vogue'
   @comp     = 'vougemagazine'
   @comp_url = 'https://www.youtube.com/user/Americanvogue'
   @incomp   = 'vougemagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bloomberg_businessweekly
   @compname = 'Bloomberg'
   @comp     = 'business'
   @comp_url = 'https://www.youtube.com/user/Bloomberg'
   @incomp   = 'bloomberg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def gq
   @compname = 'GQ Magazine'
   @comp     = 'GQMagazine'
   @comp_url = 'https://www.youtube.com/user/GQVideos'
   @incomp   = 'gq'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def hgtv
   @compname = 'HGTV'
   @comp     = 'hgtv'
   @comp_url = 'https://www.youtube.com/user/HGTV'
   @incomp   = 'hgtv'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def forbes_magazine
   @compname = 'Forbes'
   @comp     = 'Forbes'
   @comp_url = 'https://www.youtube.com/user/forbes'
   @incomp   = 'forbes'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def fortune
   @compname = 'Fortune'
   @comp     = 'FortuneMagazine'
   @comp_url = 'https://www.youtube.com/user/FortuneMagazineVideo'
   @incomp   = 'fortunemag'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def e_news
   @compname = 'E! News'
   @comp     = 'Enews'
   @comp_url = 'https://www.youtube.com/user/enews'
   @incomp   = 'enews'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def google
   @compname = 'Google'
   @comp     = 'google'
   @comp_url = 'https://www.youtube.com/user/Google'
   @incomp   = 'google'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tedtalks
   @compname = 'TED Talks'
   @comp     = 'TEDTalks'
   @comp_url = 'https://www.youtube.com/user/TEDtalksDirector'
   @incomp   = 'ted'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tesla
   @compname = 'Tesla'
   @comp     = 'TeslaMotors'
   @comp_url = 'https://www.youtube.com/user/TeslaMotors'
   @incomp   = 'teslamotors'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def victorias_secret
   @compname = "Victoria's Secret"
   @comp     = 'VictoriasSecret'
   @comp_url = 'https://www.youtube.com/user/VICTORIASSECRET'
   @incomp   = 'victoriassecret'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cnn
   @compname = 'CNN'
   @comp     = 'CNN'
   @comp_url = 'https://www.youtube.com/user/CNN'
   @incomp   = 'cnn'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end


  def hbo
   @compname = 'HBO'
   @comp     = 'HBO'
   @comp_url = 'https://www.youtube.com/user/HBO'
   @incomp   = 'hbo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def showtime
   @compname = 'Showtime'
   @comp     = 'SHO_Network'
   @comp_url = 'https://www.youtube.com/user/SHOWTIME'
   @incomp   = 'showtime'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def marvel
   @compname = 'Marvel'
   @comp     = 'Marvel'
   @comp_url = 'https://www.youtube.com/user/MARVEL'
   @incomp   = 'marvel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def syfy
   @compname = 'Syfy'
   @comp     = 'SyfyTV'
   @comp_url = 'https://www.youtube.com/user/Syfy'
   @incomp   = 'syfy'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def netflix
   @compname = 'Netflix'
   @comp     = 'netflix'
   @comp_url = 'https://www.youtube.com/user/NewOnNetflix'
   @incomp   = 'netflix'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def buzzfeed
   @compname = 'Buzzfeed'
   @comp     = 'Buzzfeed'
   @comp_url = 'https://www.youtube.com/user/BuzzFeedVideo'
   @incomp   = 'buzzfeed'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def reddit
   @compname = 'Reddit'
   @comp     = 'reddit'
   @comp_url = 'https://www.youtube.com/user/reddit'
   @incomp   = 'reddit'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def collegehumor
   @compname = 'College Humor'
   @comp     = 'CollegeHumor'
   @comp_url = 'https://www.youtube.com/user/collegehumor'
   @incomp   = 'collegehumor'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def microsoft
   @compname = 'Microsoft'
   @comp     = 'Microsoft'
   @comp_url = 'https://www.youtube.com/user/Microsoft'
   @incomp   = 'microsoft'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nike
   @compname = 'Nike'
   @comp     = 'Nike'
   @comp_url = 'https://www.youtube.com/user/nike'
   @incomp   = 'nike'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def imdb
   @compname = 'IMDb'
   @comp     = 'IMDb'
   @comp_url = 'https://www.youtube.com/user/VideoIMDb'
   @incomp   = 'imdblive'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def vevo
   @compname = 'Vevo'
   @comp     = 'Vevo'
   @comp_url = 'https://www.youtube.com/user/VEVO'
   @incomp   = 'vevo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def starwars
   @compname = 'Star Wars'
   @comp     = 'starwars'
   @comp_url = 'https://www.youtube.com/user/starwars'
   @incomp   = 'starwars'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nasa
   @compname = 'NASA'
   @comp     = 'NASA'
   @comp_url = 'https://www.youtube.com/user/NASAtelevision'
   @incomp   = 'nasa'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bravo
   @compname = 'Bravo'
   @comp     = 'Bravotv'
   @comp_url = 'https://www.youtube.com/user/BravoShows'
   @incomp   = 'bravotv'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def mtv
   @compname = 'MTV'
   @comp     = 'MTV'
   @comp_url = 'https://www.youtube.com/user/MTV'
   @incomp   = 'mtv'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp' 
  end

  def golfdigest
   @compname = 'Golf Digest'
   @comp     = 'GolfDigest'
   @comp_url = 'https://www.youtube.com/user/GolfDigestMagazine'
   @incomp   = 'golfdigest'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nba
   @compname = 'NBA'
   @comp     = 'NBA'
   @comp_url = 'https://www.youtube.com/user/NBA'
   @incomp   = 'nba'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nfl
   @compname = 'NFL'
   @comp     = 'NFL'
   @comp_url = 'https://www.youtube.com/user/NFL'
   @incomp   = 'nfl'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def mlb
   @compname = 'MLB'
   @comp     = 'MLB'
   @comp_url = 'https://www.youtube.com/user/MLB'
   @incomp   = 'mlb'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nhl
   @compname = 'NHL'
   @comp     = 'NHL'
   @incomp   = 'nhl'
   @comp_url = 'https://www.youtube.com/user/NHLVideo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def inc
   @compname = 'Inc.'
   @comp     = 'Inc'
   @incomp   = 'incmagazine'
   @comp_url = 'https://www.youtube.com/user/incmagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def makerbot
   @compname = 'Makerbot'
   @comp     = 'makerbot'
   @incomp   = 'makerbot'
   @comp_url = 'https://www.youtube.com/user/makerbot'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def olympics
   @compname = 'Olympics'
   @comp     = 'Olympics'
   @incomp   = 'olympics'
   @comp_url = 'https://www.youtube.com/user/olympic'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tmz
   @compname = 'TMZ'
   @comp     = 'TMZ'
   @incomp   = 'tmz_tv'
   @comp_url = 'https://www.youtube.com/user/TMZ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tiffany
   @compname = 'Tiffany & Co'
   @comp     = 'TiffanyandCo'
   @incomp   = 'tiffanyandco'
   @comp_url = 'https://www.youtube.com/user/OfficialTiffanyAndCo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def playboy
   @compname = 'Playboy'
   @comp     = 'Playboy'
   @incomp   = 'playboy'
   @comp_url = 'https://www.youtube.com/user/playboy'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def maxim
   @compname = 'Maxim'
   @comp     = 'MaximMag'
   @incomp   = 'maximmag'
   @comp_url = 'https://www.youtube.com/user/videosbyMaxim'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def elle
   @compname = 'Elle'
   @comp     = 'ELLEmagazine'
   @incomp   = 'elleusa'
   @comp_url = 'https://www.youtube.com/user/ElleMagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def vanityfair
   @compname = 'Vanity Fair'
   @comp     = 'VanityFair'
   @incomp   = 'vanityfair'
   @comp_url = 'https://www.youtube.com/user/VanityFairMagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brides
   @compname = 'Brides'
   @comp     = 'brides'
   @incomp   = 'brides'
   @comp_url = 'https://www.youtube.com/user/BridesMagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def usatoday
   @compname = 'USA Today'
   @comp     = 'USATODAY'
   @incomp   = 'usatoday'
   @comp_url = 'https://www.youtube.com/user/USATODAY'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sciencechannel
   @compname = 'Science Channel'
   @comp     = 'ScienceChannel'
   @incomp   = 'sciencechannel'
   @comp_url = 'https://www.youtube.com/user/ScienceChannel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def fifa
   @compname = 'FIFA'
   @comp     = 'FIFAWorldCup'
   @incomp   = 'fifaworldcup'
   @comp_url = 'https://www.youtube.com/user/FIFATV'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def gucci
   @compname = 'Gucci'
   @comp     = 'gucci'
   @incomp   = 'gucci'
   @comp_url = 'https://www.youtube.com/user/gucciofficial'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def handm
   @compname = 'H&M'
   @comp     = 'hm'
   @incomp   = 'hm'
   @comp_url = 'https://www.youtube.com/user/hennesandmauritz'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def generalelectric
   @compname = 'General Electric'
   @comp     = 'generalelectric'
   @incomp   = 'generalelectric'
   @comp_url = 'https://www.youtube.com/user/GE'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ibm
   @compname = 'IBM'
   @comp     = 'IBM'
   @incomp   = 'ibm'
   @comp_url = 'https://www.youtube.com/user/IBM'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def armani
   @compname = 'Armani'
   @comp     = 'armani'
   @incomp   = 'armai'
   @comp_url = 'https://www.youtube.com/user/Armani'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def foxsports
   @compname = 'Fox Sports'
   @comp     = 'FOXSports'
   @incomp   = 'foxsports'
   @comp_url = 'https://www.youtube.com/user/FoxSports'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cnbc
   @compname = 'CNBC'
   @comp     = 'CNBC'
   @incomp   = 'cnbc'
   @comp_url = 'https://www.youtube.com/user/cnbc'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def amazon
   @compname = 'Amazon'
   @comp     = 'amazon'
   @incomp   = 'amazon'
   @comp_url = 'https://www.youtube.com/user/amazon'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def food
   @compname = 'Food Network'
   @comp     = 'FoodNetwork'
   @incomp   = 'foodnetwork'
   @comp_url = 'https://www.youtube.com/user/FoodNetworkTV'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sony
   @compname = 'Sony'
   @comp     = 'Sony'
   @incomp   = 'sony'
   @comp_url = 'https://www.youtube.com/user/Sonyelectronics'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def gap
   @compname = 'Gap'
   @comp     = 'Gap'
   @incomp   = 'gap'
   @comp_url = 'https://www.youtube.com/user/Gap'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def history
   @compname = 'History'
   @comp     = 'HISTORY'
   @incomp   = 'history'
   @comp_url = 'https://www.youtube.com/user/historychannel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ralph
   @compname = 'Ralph Lauren'
   @comp     = 'RalphLauren'
   @incomp   = 'ralphlauren'
   @comp_url = 'https://www.youtube.com/user/RLTVralphlauren'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tlc
   @compname = 'TLC'
   @comp     = 'TLC'
   @incomp   = 'tlc'
   @comp_url = 'https://www.youtube.com/user/TLC'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def xbox
   @compname = 'Xbox'
   @comp     = 'Xbox'
   @incomp   = 'xbox'
   @comp_url = 'https://www.youtube.com/user/xbox'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def playstation
   @compname = 'PlayStation'
   @comp     = 'PlayStation'
   @incomp   = 'playstation'
   @comp_url = 'https://www.youtube.com/user/PlayStation'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nordstrom
   @compname = 'Nordstrom'
   @comp     = 'Nordstrom'
   @incomp   = 'nordstrom'
   @comp_url = 'https://www.youtube.com/user/Nordstromcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def entrepreneur
   @compname = 'Entrepreneur'
   @comp     = 'Entrepreneur'
   @incomp   = 'Entrepreneur'
   @comp_url = 'https://www.youtube.com/user/EntrepreneurOnline'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bananarepublic
   @compname = 'Banana Republic'
   @comp     = 'BananaRepublic'
   @incomp   = 'bananarepublic'
   @comp_url = 'https://www.youtube.com/user/bananarepublic'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def calvinklein
   @compname = 'Calvin Klein'
   @comp     = 'CalvinKlein'
   @incomp   = 'calvinklein'
   @comp_url = 'https://www.youtube.com/user/calvinklein'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def underarmour
   @compname = 'Under Armour'
   @comp     = 'UnderArmour'
   @incomp   = 'underarmour'
   @comp_url = 'https://www.youtube.com/user/underarmour'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def facebook
   @compname = 'Facebook'
   @comp     = 'facebook'
   @incomp   = 'facebook'
   @comp_url = 'https://www.youtube.com/user/theofficialfacebook'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def burberry
   @compname = 'Burberry'
   @comp     = 'Burberry'
   @incomp   = 'burberry'
   @comp_url = 'https://www.youtube.com/user/Burberry'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def abc
   @compname = 'ABC'
   @comp     = 'ABCNetwork'
   @incomp   = 'abcnetwork'
   @comp_url = 'https://www.youtube.com/user/ABCNetwork'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nbc
   @compname = 'NBC'
   @comp     = 'nbc'
   @incomp   = 'nbctv'
   @comp_url = 'https://www.youtube.com/user/NBC'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cbs
   @compname = 'CBS'
   @comp     = 'cbs'
   @incomp   = 'cbstv'
   @comp_url = 'https://www.youtube.com/user/CBS'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thecw
   @compname = 'The CW'
   @comp     = 'CW_network'
   @incomp   = 'thecw'
   @comp_url = 'https://www.youtube.com/user/Cwtelevision'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def hugoboss
   @compname = 'Hugo Boss'
   @comp     = 'HUGOBOSS'
   @incomp   = 'hugoboss'
   @comp_url = 'https://www.youtube.com/user/HUGOBOSSTV'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cbsnews
   @compname = 'CBS News'
   @comp     = 'CBSNews'
   @incomp   = 'cbsnews'
   @comp_url = 'https://www.youtube.com/user/CBSNewsOnline'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def foxnews
   @compname = 'Fox News'
   @comp     = 'FoxNews'
   @incomp   = 'foxnews'
   @comp_url = 'https://www.youtube.com/user/FoxNewsChannel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nbcnews
   @compname = 'NBC News'
   @comp     = 'NBCNews'
   @incomp   = 'nbcnews'
   @comp_url = 'https://www.youtube.com/user/NBCNews'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def abcnews
   @compname = 'ABC News'
   @comp     = 'ABC'
   @incomp   = 'abcnews'
   @comp_url = 'https://www.youtube.com/user/ABCNews'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cbssports
   @compname = 'CBS Sports'
   @comp     = 'CBSSports'
   @incomp   = 'cbssports'
   @comp_url = 'https://www.youtube.com/user/CBSSports'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def fox
   @compname = 'Fox'
   @comp     = 'FOXTV'
   @incomp   = 'foxtv'
   @comp_url = 'https://www.youtube.com/user/FoxBroadcasting'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def uber
   @compname = 'Uber'
   @comp     = 'Uber'
   @incomp   = 'uber'
   @comp_url = 'https://www.youtube.com/user/UberWorldwide'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def forever21
   @compname = 'Forever 21'
   @comp     = 'Forever21'
   @incomp   = 'forever21'
   @comp_url = 'https://www.youtube.com/user/Forever21Inc'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def mls
   @compname = 'MLS'
   @comp     = 'MLS'
   @incomp   = 'mls'
   @comp_url = 'https://www.youtube.com/user/mls'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def urbanoutfitters
   @compname = 'Urban Outfitters'
   @comp     = 'UrbanOutfitters'
   @incomp   = 'urbanoutfitters'
   @comp_url = 'https://www.youtube.com/user/uotv'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def allure
   @compname = 'Allure'
   @comp     = 'Allure_magazine'
   @incomp   = 'allure'
   @comp_url = 'https://www.youtube.com/user/AllureMagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def wmagazine
   @compname = 'W Magazine'
   @comp     = 'wmag'
   @incomp   = 'wmag'
   @comp_url = 'https://www.youtube.com/user/wmagazinedotcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thescene
   @compname = 'The Scene'
   @comp     = 'SCENE'
   @incomp   = 'thescene'
   @comp_url = 'https://www.youtube.com/user/thesceneYT'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def youtube
   @compname = 'YouTube'
   @comp     = 'YouTube'
   @incomp   = 'youtube'
   @comp_url = 'https://www.youtube.com/user/Youtube'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def business_connector
  end

  def celebrity_connector
  end

  def katyperry_celeb
   @compname = 'Katy Perry'
   @comp     = 'katyperry'
   @incomp   = 'katyperry'
   @comp_url = 'https://www.youtube.com/user/KatyPerryVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def barackobama
   @compname = 'Barack Obama'
   @comp     = 'BarackObama'
   @incomp   = 'barackobama'
   @comp_url = 'https://www.youtube.com/user/BarackObamadotcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def taylorswift
   @compname = 'Taylor Swift'
   @comp     = 'taylorswift13'
   @incomp   = 'taylorswift'
   @comp_url = 'https://www.youtube.com/user/TaylorSwiftVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ladygaga
   @compname = 'Lady Gaga'
   @comp     = 'ladygaga'
   @incomp   = 'ladygaga'
   @comp_url = 'https://www.youtube.com/user/LadyGagaVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def justintimberlake
   @compname = 'Justin Timberlake'
   @comp     = 'jtimberlake'
   @incomp   = 'justintimberlake'
   @comp_url = 'https://www.youtube.com/user/justintimberlakeVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brittneyspears
   @compname = 'Britney Spears'
   @comp     = 'britneyspears'
   @incomp   = 'britneyspears'
   @comp_url = 'https://www.youtube.com/user/BritneySpearsVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def kimkardashianwest
   @compname = 'Kim Kardashian'
   @comp     = 'KimKardashian'
   @incomp   = 'kimkardashian'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def shakira
   @compname = 'Shakira'
   @comp     = 'shakira'
   @incomp   = 'shakira'
   @comp_url = 'https://www.youtube.com/user/shakiraVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jenniferlopez
   @compname = 'Jennifer Lopez'
   @comp     = 'JLo'
   @incomp   = 'jlo'
   @comp_url = 'https://www.youtube.com/user/JenniferLopez'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def selenagomez
   @compname = 'Selena Gomez'
   @comp     = 'selenagomez'
   @incomp   = 'selenagomez'
   @comp_url = 'https://www.youtube.com/user/SelenaGomezVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def arianagrande
   @compname = 'Ariana Grande'
   @comp     = 'ArianaGrande'
   @incomp   = 'arianagrande'
   @comp_url = 'https://www.youtube.com/user/ArianaGrandeVevo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def demilovato
   @compname = 'Demi Lovato'
   @comp     = 'ddlovato'
   @incomp   = 'ddlovato'
   @comp_url = 'https://www.youtube.com/user/DemiLovatoVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jimmyfallon
   @compname = 'Jimmy Fallon'
   @comp     = 'jimmyfallon'
   @incomp   = 'jimmyfallon'
   @comp_url = 'https://www.youtube.com/user/latenight'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def lebronjames
   @compname = 'LeBron James'
   @comp     = 'KingJames'
   @incomp   = 'kingjames'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def adele
   @compname = 'Adele'
   @comp     = 'OfficialAdele'
   @incomp   = 'adele'
   @comp_url = 'https://www.youtube.com/user/AdeleVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brunomars
   @compname = 'Bruno Mars'
   @comp     = 'BrunoMars'
   @incomp   = 'brunomars'
   @comp_url = 'https://www.youtube.com/user/ElektraRecords'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def aliciakeys
   @compname = 'Alicia Keys'
   @comp     = 'aliciakeys'
   @incomp   = 'aliciakeys'
   @comp_url = 'https://www.youtube.com/user/aliciakeysVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def mileyraycyrus
   @compname = 'Miley Cyrus'
   @comp     = 'MileyCyrus'
   @incomp   = 'mileycyrus'
   @comp_url = 'https://www.youtube.com/user/MileyCyrusVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nickiminaj
   @compname = 'Nicki Minaj'
   @comp     = 'NICKIMINAJ'
   @incomp   = 'nickiminaj'
   @comp_url = 'https://www.youtube.com/user/NickiMinajAtVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def emmawatson
   @compname = 'Emma Watson'
   @comp     = 'EmWatson'
   @incomp   = 'emmawatson'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def neilpatrickharris
   @compname = 'Neil Patrick Harris'
   @comp     = 'ActuallyNPH'
   @incomp   = 'nph'
   @comp_url = 'https://www.youtube.com/channel/UCk_Dx67t-aXqw9uQLVX-UCQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def davidguetta
   @compname = 'David Guetta'
   @comp     = 'davidguetta'
   @incomp   = 'davidguetta'
   @comp_url = 'https://www.youtube.com/user/davidguettavevo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def conanobrien
   @compname = 'Conan OBrien'
   @comp     = 'ConanOBrien'
   @incomp   = 'teamcoco'
   @comp_url = 'https://www.youtube.com/user/teamcoco'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def khloekardashian
   @compname = 'Khloe Kardashian'
   @comp     = 'KhloeKardashian'
   @incomp   = 'kloekardashianthegirl'
   @comp_url = 'https://www.youtube.com/channel/UCJy0RHFC64EC-kqWOfhCb_g'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def kourtneykardashian
   @compname = 'Kourtney Kardashian'
   @comp     = 'kourtneykardashian'
   @incomp   = 'kourtneykardash'
   @comp_url = 'https://www.youtube.com/channel/UCXIf9YuOaiCSn2r4P5SZ_Zw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def christinaaguilera
   @compname = 'Christina Aguilera'
   @comp     = 'xtina'
   @incomp   = 'xtina'
   @comp_url = 'https://www.youtube.com/user/CAguileraVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def beyonce
   @compname = 'Beyonce'
   @comp     = 'Beyonce'
   @incomp   = 'beyonce'
   @comp_url = 'https://www.youtube.com/user/beyonceVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def oprahwinfrey
   @compname = 'Oprah Winfrey'
   @comp     = 'Oprah'
   @incomp   = 'oprah'
   @comp_url = 'https://www.youtube.com/channel/UCqL0gza-KJcuVe3e0FCbM8Q'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def johnnydepp
   @compname = 'Johnny Depp'
   @comp     = 'realdepp'
   @incomp   = 'johnnydepp.oficial'
   @comp_url = 'https://www.youtube.com/channel/UCPP2obRMCcnokAqR4NzMuwQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def scarlettjohansson
   @compname = 'Scarlett Johansson'
   @comp     = 'ScarlettJOnline'
   @incomp   = 'scarlettjohanssonaddict'
   @comp_url = 'https://www.youtube.com/channel/UCuaGAGmxgipdJEOrYaMT0Nw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def madonna
   @compname = 'Madonna'
   @comp     = 'Madonna'
   @incomp   = 'madonna'
   @comp_url = 'https://www.youtube.com/user/madonna'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tomhanks
   @compname = 'Tom Hanks'
   @comp     = 'tomhanks'
   @incomp   = 'tomhanks'
   @comp_url = 'https://www.youtube.com/user/tomhankschannel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jessicaalba
   @compname = 'Jessica Alba'
   @comp     = 'jessicaalba'
   @incomp   = 'jessicaalba'
   @comp_url = 'https://www.youtube.com/channel/UCPJorwl_vxgiNni6Mas8a7A'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def meganfox
   @compname = 'Megan Fox'
   @comp     = 'meganfox'
   @incomp   = 'dailymeganfox'
   @comp_url = 'https://www.youtube.com/channel/UCsN68XRv5dVieQizOcLyzOg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tigerwoods
   @compname = 'Tiger Woods'
   @comp     = 'TigerWoods'
   @incomp   = 'TigerWoods'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end
  
  def blakelively
   @compname = 'Blake Lively'
   @comp     = 'blakelively'
   @incomp   = 'blakelively'
   @comp_url = 'https://www.youtube.com/channel/UCKMKpIg3ZXn-7_xr4RAuQjA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def leonardodicaprio
   @compname = 'Leonardo DiCaprio'
   @comp     = 'LeoDiCaprio'
   @incomp   = 'leonardodicaprio'
   @comp_url = 'https://www.youtube.com/channel/UCc5HhOHhTKOMK_ta2lqtKgw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def emmastone
   @compname = 'Emma Stone'
   @comp     = 'EmmaStoneWeb'
   @incomp   = 'emmastone_official_'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jayz
   @compname = 'Jay Z'
   @comp     = 'JayZClassicBars'
   @incomp   = 'shawn.carter '
   @comp_url = 'https://www.youtube.com/user/JayZVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ellendegeneres
   @compname = 'Ellen DeGeneres'
   @comp     = 'TheEllenShow'
   @incomp   = 'theellenshow'
   @comp_url = 'https://www.youtube.com/user/TheEllenShow'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sandrabullock
   @compname = 'Sandra Bullock'
   @comp     = 'sbullockweb'
   @incomp   = 'sandrabullockig'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ashleygreene
   @compname = 'Ashley Greene'
   @comp     = 'AshleyMGreene'
   @incomp   = 'ashleygreene'
   @comp_url = 'https://www.youtube.com/channel/UCEHOQe7Kk_4F6LvAcPp1SKQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def natalieportman
   @compname = 'Natalie Portman'
   @comp     = 'PortmanUpdate'
   @incomp   = 'natalieportmanlove'
   @comp_url = 'https://www.youtube.com/channel/UC7M0_DE8EhWTpSgRqiuToCA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jenniferlawrence
   @compname = 'Jennifer Lawrence'
   @comp     = 'MsJenniferLaw'
   @incomp   = 'jenniferlawrencepx'
   @comp_url = 'https://www.youtube.com/channel/UC1SBXt6T5VT12_UFUupLWXA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def katebosworth
   @compname = 'Kate Bosworth'
   @comp     = 'katebosworth'
   @incomp   = 'katebosworth'
   @comp_url = 'https://www.youtube.com/channel/UC-jXKCYtzcMjBr8f66hyEvA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def camerondiaz
   @compname = 'Cameron Diaz'
   @comp     = 'CameronDiaz'
   @incomp   = 'camerondiaz'
   @comp_url = 'https://www.youtube.com/channel/UC9k-NlU7gjr8F0HlCTAWlXQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def floydmayweather
   @compname = 'Floyd Mayweather'
   @comp     = 'FloydMayweather'
   @incomp   = 'floydmayweather'
   @comp_url = 'https://www.youtube.com/user/FloydMayweather'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def reesewitherspoon
   @compname = 'Reese Witherspoon'
   @comp     = 'RWitherspoon'
   @incomp   = 'reesewitherspoon'
   @comp_url = 'https://www.youtube.com/channel/UCE20hbhrnFW3bhndXukSxAg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def kateupton
   @compname = 'Kate Upton'
   @comp     = 'KateUpton'
   @incomp   = 'kateupton'
   @comp_url = 'https://www.youtube.com/channel/UCyXW3LwGzBo1gQ8DOg7L5Nw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def peterdinklage
   @compname = 'Peter Dinklage'
   @comp     = 'Peter_Dinklage'
   @incomp   = 'peterdinklage'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def milakunis
   @compname = 'Milla Kunis'
   @comp     = 'Milla_Kunis'
   @incomp   = 'milakunis______'
   @comp_url = 'https://www.youtube.com/channel/UCl6qhIrV6It5TCyjS6Cq2lg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  #####TVSHOWS
  def tv_show_connector
  end

  def lastweektonight
   @compname = 'Last Week Tonight'
   @comp     = 'LastWeekTonight'
   @incomp   = 'lastweektonight'
   @comp_url = 'https://www.youtube.com/user/LastWeekTonight'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

end



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


# ####MUSIC


# One Direction           onedirection        onedirection          https://www.youtube.com/user/OneDirectionVEVO
# Katy Perry              katyperry           katyperry             https://www.youtube.com/user/KatyPerryVEVO
# Beyonce                 Beyonce             beyonce               https://www.youtube.com/user/beyonceVEVO
# Taylor Swift            taylorswift13       taylorswift           https://www.youtube.com/user/TaylorSwiftVEVO
# Justin Timberlake       jtimberlake         justintimberlake      https://www.youtube.com/user/justintimberlakeVEVO
# Iggy Azalea             IGGYAZALEA          thenewclassic         https://www.youtube.com/user/iggyazaleamusicVEVO
# Ariana Grande           ArianaGrande        arianagrande          https://www.youtube.com/user/ArianaGrandeVevo
# Miley Cyrus             MileyCyrus          mileycyrus            https://www.youtube.com/user/MileyCyrusVEVO
# Pharrel Williams        Pharrell            pharrell              https://www.youtube.com/user/PharrellWilliamsVEVO
# Eminem                  Eminem              eminem                https://www.youtube.com/user/EminemVEVO
# Lorde                   lordemusic          lordemusic            https://www.youtube.com/user/LordeVEVO
# Luke Bryan              LukeBryanOnline     lukebryan             https://www.youtube.com/user/LukeBryanVEVO
# Sam Smith               samsmithworld       samsmithworld         https://www.youtube.com/user/SamSmithWorldVEVO
# John Legend             johnlegend          johnlegend            https://www.youtube.com/user/johnlegendVEVO
# OneRepublic             OneRepublic         onerepublic           https://www.youtube.com/user/OneRepublicVEVO
# Drake                   Drake               leaderofnewschool     https://www.youtube.com/user/DrakeVEVO
# Jason Derulo            jasonderulo         jasonderulo           https://www.youtube.com/user/JasonDerulo
# Justin Bieber           justinbieber        justinbieber          https://www.youtube.com/user/JustinBieberVEVO
# Imagine Dragons         imaginedragons      imaginedragons        https://www.youtube.com/user/ImagineDragonsVEVO
# Florida Georgia Line    FLAGALine           flagaline             https://www.youtube.com/user/FlaGeorgiaLineVEVO
# Nicki Minaj             NICKIMINAJ          nickiminaj            https://www.youtube.com/user/NickiMinajAtVEVO
# 5 Seconds Of Summer     5SOS                5sos                  https://www.youtube.com/user/5sosvevo
# Lady Gaga               ladygaga            ladygaga              https://www.youtube.com/user/LadyGagaVEVO
# Pitbull                 pitbull             pitbull               https://www.youtube.com/user/PitbullVEVO
# Bruno Mars              BrunoMars           brunomars             https://www.youtube.com/user/ElektraRecords
# Jason Aldean            Jason_Aldean        jasonaldean           https://www.youtube.com/user/JasonAldeanVEVO
# Maroon 5                maroon5             maroon5               https://www.youtube.com/user/Maroon5VEVO
# Chris Brown             chrisbrown          chrisbrownofficial    https://www.youtube.com/user/ChrisBrownVEVO
# Meghan Trainor          Meghan_Trainor      meghan_trainor        https://www.youtube.com/user/MeghanTrainorVEVO
# Bastille                bastilledan         bastilledan           https://www.youtube.com/user/BastilleVEVO
# Avicii                  Avicii              avicii                https://www.youtube.com/user/AviciiOfficialVEVO
# Magic!                  ournameisMAGIC      ournameismagic        https://www.youtube.com/user/ournameismagicVEVO
# Demi Lovato             ddlovato            ddlovato              https://www.youtube.com/user/DemiLovatoVEVO
# Blake Shelton           blakeshelton        blakeshelton          https://www.youtube.com/user/blakeshelton
# Coldplay                coldplay            coldplay              https://www.youtube.com/user/ColdplayVEVO
# Charli XCX              charli_xcx          charli_xcx            https://www.youtube.com/user/officialcharlixcx
# Nico & Vinz             NicoandVinz         nicoandvinz           https://www.youtube.com/user/envymusicchannel
# The Rolling Stones      RollingStones       therollingstones      https://www.youtube.com/user/TheRollingStones
# Shakira                 shakira             shakira               https://www.youtube.com/user/shakiraVEVO
# Passenger               passengermusic      passengermusic        https://www.youtube.com/user/passengermusic
# Brantley Gilbert        BrantleyGilbert     brantleygilbert       https://www.youtube.com/user/BrantleyGilbertVEVO
# Ellie Goulding          elliegoulding       elliegoulding         https://www.youtube.com/user/EllieGouldingVEVO
# Eric Church             ericchurch          ericchurchmusic       https://www.youtube.com/user/EricChurchVEVO
# Idina Menzel            idinamenzel         idinamenzel           https://www.youtube.com/user/Idinamenzel
# Selena Gomez            selenagomez         selenagomez           https://www.youtube.com/user/SelenaGomezVEVO
# Calvin Harris           CalvinHarris        calvinharris          https://www.youtube.com/user/CalvinHarrisVEVO
# Michael Buble           michaelbuble        michaelbuble          https://www.youtube.com/user/MichaelBubleTV
# Michael Jackson         michaeljackson      michaeljackson        https://www.youtube.com/user/michaeljacksonVEVO
# Britney Spears          britneyspears       britneyspears         https://www.youtube.com/user/BritneySpearsVEVO
# Kelly Clarkson          kelly_clarkson      kellyclarkson         https://www.youtube.com/user/kellyclarksonVEVO
# Christina Aguilera      xtina               xtina                 https://www.youtube.com/user/CAguileraVEVO



# #######Sports

# Real Madrid                     realmadrid        realmadrid            https://www.youtube.com/user/realmadridcf
# Dallas Cowboys                  dallascowboys     dallascowboys         https://www.youtube.com/channel/UCdjR8pv3bU7WLRshUMwxDVw
# New York Yankees                Yankees           yankees               https://www.youtube.com/channel/UCQNgE6-Q5OBvLzhyAmWZItQ
# Barcelona                       FCBarcelona       fcbarcelona           https://www.youtube.com/user/fcbarcelona
# Manchester United               ManUtd            manchesterunited      https://www.youtube.com/channel/UCKHRBMEiy-GuV-F7JQbJWLg
# Los Angeles Lakers              Lakers            lakers                https://www.youtube.com/user/lakersnationdotcom
# New England Patriots            Patriots          patriots              https://www.youtube.com/channel/UCF54f0UTZ2ctCDs5yJjDblQ
# New York Knicks                 nyknicks          nyknicks              https://www.youtube.com/user/nyknicks
# Los Angeles Dodgers             Dodgers           dodgers               https://www.youtube.com/channel/UCg_8DdhmyMMxa8Xwbcmm-_w
# Washington Redskins             Redskins          redskins              https://www.youtube.com/user/redskinsdotcom
# Bayern Munich                   FCBayern          fcbayern              https://www.youtube.com/user/fcbayern
# Boston Red Sox                  RedSox            redsox                https://www.youtube.com/channel/UC3FcTH3wcqNWHx4T6iICz_g
# New York Giants                 Giants            nygiants              https://www.youtube.com/channel/UCnEubDTRusG-qvohSNyCuWg
# Chicago Bulls                   chicagobulls      chicagobulls          https://www.youtube.com/user/chicagobullsofficial
# San Francisco Giants            SFGiants          sfgiants              none
# Houston Texans                  HoustonTexans     houstontexans         https://www.youtube.com/channel/UC3fjWR24Ej6EfvMv6Hqq28g
# Chicago Cubs                    Cubs              cubs                  https://www.youtube.com/channel/UCbtkUT23QOxQb1w1aP-tRIA
# New York Jets                   nyjets            nyjets                https://www.youtube.com/channel/UCNdo59IgJRskCLP7FBWqe6w
# Philadelphia Eagles             Eagles            philadelphiaeagles    https://www.youtube.com/channel/UCaogx6OHpsGg0zuGRKsjbtQ
# Boston Celtics                  celtics           celtics               https://www.youtube.com/user/bostonceltics
# Chicago Bears                   ChicagoBears      chicagobears          https://www.youtube.com/channel/UCP0Cdc6moLMyDJiO0s-yhbQ
# Los Angeles Clippers            LAClippers        laclippers            https://www.youtube.com/user/clippers1970
# San Francisco 49ers             49ers             49ers                 https://www.youtube.com/user/sanfrancisco49ers
# Baltimore Ravens                Ravens            ravens                https://www.youtube.com/user/baltimoreravens
# Brooklyn Nets                   BrooklynNets      brooklynnets          https://www.youtube.com/user/NBANets
# Denver Broncos                  Broncos           broncos               https://www.youtube.com/channel/UCe6XsNDeY3pxqXJMc_iheUA
# Indianapolis Colts              Colts             colts                 none
# St. Louis Cardinals             Cardinals         cardinals             https://www.youtube.com/channel/UCYPeuBXCeFOq5QfhEnUfr8A
# Green Bay Packers               packers           packers               https://www.youtube.com/channel/UC_C4jeUvhqbsOFCCMql5sHg
# Manchester City                 MCFC              mcfcofficial          https://www.youtube.com/user/mcfcofficial
# Chelsea                         ChelseaFC         chelseafc             https://www.youtube.com/user/chelseafc
# Ferrari                         Ferrari           ferrariusa            https://www.youtube.com/user/ferrariworld
# New York Mets                   Mets              mets                  none
# Pittsburgh Steelers             steelers          steelers              https://www.youtube.com/channel/UCR6rBAe6fuKAJjdg4dbAcqg
# Seattle Seahawks                Seahawks          seahawks              https://www.youtube.com/user/seahawksdotcom
# Arsenal                         Arsenal           arsenal               https://www.youtube.com/user/ArsenalTour
# Golden State Warriors           warriors          warriors              https://www.youtube.com/user/GoldenStateWarriors
# Los Angeles Angels Of Anaheim   Angels            angels                none
# Miami Dolphins                  MiamiDolphins     miamidolphins         https://www.youtube.com/channel/UCdbljRu3B3WIYliBJat_wsg
# Toronto Maple Leafs             MapleLeafs        mapleleafs            https://www.youtube.com/user/torontomapleleafs
# Washington Nationals            Nationals         nationals             https://www.youtube.com/channel/UCQh28Q2ew4jVoNcDyRygeBw
# Carolina Panthers               Panthers          panthers              https://www.youtube.com/channel/UCDmv5BcYE3hQW354jk9W0Cg
# Houston Rockets                 HoustonRockets    houstonrockets        https://www.youtube.com/channel/UCmjAHvW8SC7vmhCFomfyV7Q
# Philadelphia Phillies           Phillies          phillies              https://www.youtube.com/channel/UCQh91_NPlNSpWWfqcVLUMTQ
# Tampa Bay Buccaneers            TBBuccaneers      tbbuccaneers          https://www.youtube.com/channel/UC_DXo-lcvFwMWCYNgHP4_tg
# Texas Rangers                   Rangers           rangers               none
# Miami Heat                      MiamiHEAT         miamiheat             https://www.youtube.com/user/miamiheat
# Tennessee Titans                Titans            tennesseetitans       https://www.youtube.com/channel/UCZIg4NlOuW_ReCVVZ64eLlw
# Atlanta Braves                  Braves            braves                https://www.youtube.com/channel/UCglKlWno0PXtVhWWQLyQyPQ
# Minnesota Vikings               Vikings           vikings               https://www.youtube.com/channel/UCSb9A1uBRGUHfSyKCrhfXYA
# Arizona Cardinals               AZCardinals       azcardinals           https://www.youtube.com/channel/UC9YrTlASDs12N2SosBvl8tQ



# #####Food

# Allrecipes              Allrecipes      allrecipes                https://www.youtube.com/user/allrecipes
# Cooking.com             CookingCom      cookingcom                https://www.youtube.com/user/cookingcom
# Food Network            FoodNetwork     foodnetwork               https://www.youtube.com/user/FoodNetworkTV
# The Kitchn              thekitchn       thekitchn                 https://www.youtube.com/channel/UCuNKgYLb0wOoMvclzSlBvbQ
# Open Table              OpenTable       opentable                 None
# Taste Of Home           tasteofhome     tasteofhome               https://www.youtube.com/user/tasteofhome
# Epicurious              epicurious      epicurious                https://www.youtube.com/user/epicuriousdotcom
# Grubhub                 GrubHub         grubhub                   https://www.youtube.com/user/grubhub
# Seamless                Seamless        eatseamless               https://www.youtube.com/user/eatseamless
# Yummly                  yummly          yummly                    https://www.youtube.com/user/Yummly1
# Huffington Post Food    HuffPostFood    huffpostfood              None
# Food.com                Fooddotcom      fooddotcom                None
# Bonappetit              bonappetit      bonappetitmag             https://www.youtube.com/user/BonAppetitDotCom
# Weight Watchers         WeightWatchers  weightwatchers            https://www.youtube.com/user/WeightWatchers
# Food And Wine           FoodAndWineMag  foodandwine               https://www.youtube.com/user/foodandwinevideo
# The Chew                thechew         abcthechew                https://www.youtube.com/channel/UC-Hz_loYacm45SBtSVA0lRA
# Americas Test Kitchen   TestKitchen     testkitchen               https://www.youtube.com/user/americastestkitchen
# Iron Chef America       IronChefAmerica ironchefamericacuisine    https://www.youtube.com/channel/UCoag6CfTHLeHuqtCpvo7o7Q

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

# Budget Travel         BudgetTravel    budgettravel            None
# Afar                  AFARmedia       afarmedia               None
# Travel And Leisure    TravelLeisure   travelandleisure        None
# Conde Nast Traveler   CNTraveler      cntraveler              None
# Geographical          GeographicalMag geographical_magazine   None
# National Geographic   NatGeo          natgeotravel            None
# Wanderlust            WanderlustFest  wanderlustfest          None

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


# #####FASHION

# Armani                Armani            armani            https://www.youtube.com/user/Armani
# Burberry              Burberry          burberry          https://www.youtube.com/user/Burberry
# Calvin Klein          CalvinKlein       calvinklein       https://www.youtube.com/user/calvinklein
# Chanel                CHANEL            chanelofficial    https://www.youtube.com/user/CHANEL
# Christian Dior        Dior              dior              https://www.youtube.com/user/Dior
# Christian Louboutin   LouboutinWorld    louboutinworld    https://www.youtube.com/user/christianlouboutin
# Dolce & Gabbana       dolcegabbana      dolcegabbana      https://www.youtube.com/user/dolcegabbanachannel
# DKNY                  dkny              dkny              https://www.youtube.com/user/dkny
# Escada                ESCADA            escadaofficial    https://www.youtube.com/user/Escadaeditor
# Fendi                 Fendi             fendi             https://www.youtube.com/user/FENDICHANNEL
# Gucci                 gucci             gucci             https://www.youtube.com/user/gucciofficial
# Prada                 Prada             prada             https://www.youtube.com/user/PRADA
# Hugo Boss             HUGOBOSS          hugoboss          https://www.youtube.com/user/HUGOBOSSTV
# John Varvatos         johnvarvatos      johnvarvatos      https://www.youtube.com/user/johnvarvatos
# La Perla Lingerie     LaPerlaLingerie   laperlalingerie   https://www.youtube.com/user/LaPerlaLingerie
# Louis Vuitton         LouisVuitton      louisvuitton      https://www.youtube.com/user/LOUISVUITTON
# Manolo Blahnik        ManoloBlahnik     manoloblahnikhq   https://www.youtube.com/channel/UCBldabiGA8UYQQgbwyI-jyw
# Missoni               Missoni           missoni           https://www.youtube.com/user/MissoniOfficial
# Ralph Lauren          RalphLauren       ralphlauren       https://www.youtube.com/user/RLTVralphlauren
# Roland Mouret         RolandMouret      roland_mouret     https://www.youtube.com/user/RolandMouretFilms
# Stella McCartney      StellaMcCartney   stellamccartney   https://www.youtube.com/user/stellamccartney1
# Tom Ford              TOMFORD           tomford           https://www.youtube.com/user/TOMFORDINTERNATIONAL
# Versace               Versace           versace_official  https://www.youtube.com/user/VersaceVideos
# Michael Kors          MichaelKors       michaelkors       https://www.youtube.com/user/michaelkors






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