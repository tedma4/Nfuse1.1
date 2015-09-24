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

  def katyperry
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

  def britneyspears
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

  def gameofthrones
   @compname = 'Game Of Thrones'
   @comp     = 'GameOfThrones'
   @incomp   = 'gameofthrones'
   @comp_url = 'https://www.youtube.com/user/GameofThrones'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bettercallsaul
   @compname = 'Better Call Saul'
   @comp     = 'BetterCallSaul'
   @incomp   = 'bettercallsaulamc'
   @comp_url = 'https://www.youtube.com/channel/UCCab9hOn5MELbKB__AOU3RQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def orangeisthenewblack
   @compname = 'Orange Is The New Black'
   @comp     = 'OITNB'
   @incomp   = 'oitnb'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def empire
   @compname = 'Empire'
   @comp     = 'EmpireFox'
   @incomp   = 'empirefox'
   @comp_url = 'https://www.youtube.com/user/EMPIREonFOX'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def howimetyourmother
   @compname = 'HIMYM'
   @comp     = 'OfficialHIMYM'
   @incomp   = 'himym_official'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def madmen
   @compname = 'Mad Men'
   @comp     = 'MadMen_AMC'
   @incomp   = 'madmen_amc'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def theamericans
   @compname = 'The Americans'
   @comp     = 'TheAmericansFX'
   @incomp   = 'theamericansfx'
   @comp_url = 'https://www.youtube.com/user/TheAmericansFX'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thetonightshow
   @compname = 'The Tonight Show'
   @comp     = 'FallonTonight'
   @incomp   = 'fallontonight'
   @comp_url = 'https://www.youtube.com/user/latenight'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def truedetective
   @compname = 'True Detective'
   @comp     = 'TrueDetective'
   @incomp   = 'truedetective'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def justified
   @compname = 'Justified'
   @comp     = 'JustifiedFX'
   @incomp   = 'justifiedfx'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sense8
   @compname = 'Sense8'
   @comp     = 'sense8'
   @incomp   = 'sense8'
   @comp_url = 'https://www.youtube.com/channel/UC7Vsk1omEqLSbxKdnSqYvXw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def izombie
   @compname = 'iZombie'
   @comp     = 'CWiZombie'
   @incomp   = 'thecwizombie'
   @comp_url = 'https://www.youtube.com/channel/UCtgIz5m-kWXdHOPYLp5Banw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def theflash
   @compname = 'The Flash'
   @comp     = 'CW_TheFlash'
   @incomp   = 'thecwizombie'
   @comp_url = 'https://www.youtube.com/user/barryallentheflash1'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thebachelor
   @compname = 'The Bachelor'
   @comp     = 'BachelorABC'
   @incomp   = 'bachelorabc'
   @comp_url = 'https://www.youtube.com/channel/UCXyOZBTth57gdz6k7KPHOsw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def suits
   @compname = 'Suits'
   @comp     = 'Suits_USA'
   @incomp   = 'suits_usa'
   @comp_url = 'https://www.youtube.com/user/SuitsonUSA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def theellenshow
   @compname = 'The Ellen Show'
   @comp     = 'TheEllenShow'
   @incomp   = 'theellenshow'
   @comp_url = 'https://www.youtube.com/user/TheEllenShow'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def greysanatomy
   @compname = 'Greys Anatomy'
   @comp     = 'GreysABC'
   @incomp   = 'greysabc'
   @comp_url = 'https://www.youtube.com/channel/UC5lWD_N9kq8IdWzLOdy5fow'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thewalkingdead
   @compname = 'The Walking Dead'
   @comp     = 'WalkingDead_AMC'
   @incomp   = 'amcthewalkingdead'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def americanhorrorstory
   @compname = 'American Horror Story'
   @comp     = 'AmericanHorrorStory'
   @incomp   = 'americanhorrorstory'
   @comp_url = 'https://www.youtube.com/user/qwerty19107'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sharktank
   @compname = 'Shark Tank'
   @comp     = 'ABCSharkTank'
   @incomp   = 'sharktankabc'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def gotham
   @compname = 'Gotham'
   @comp     = 'Gotham'
   @incomp   = 'gothamonfox'
   @comp_url = 'https://www.youtube.com/user/GothamFOX'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thegoodwife
   @compname = 'The Good Wife'
   @comp     = 'TheGoodWife_CBS'
   @incomp   = 'thegoodwife_cbs'
   @comp_url = 'https://www.youtube.com/user/thegoodwife'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thebigbangtheory
   @compname = 'The Big Bang Theory'
   @comp     = 'BigBang_CBS'
   @incomp   = 'bigbangtheory_cbs'
   @comp_url = 'https://www.youtube.com/user/thebigbangtheory'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def theblacklist
   @compname = 'Blacklist'
   @comp     = 'NBCBlacklist'
   @incomp   = 'nbcblacklist'
   @comp_url = 'https://www.youtube.com/user/NBCBlacklist'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def howtogetawaywithmurder
   @compname = 'How To Get Away'
   @comp     = 'HowToGetAwayABC'
   @incomp   = 'howtogetawaywithmurder'
   @comp_url = 'https://www.youtube.com/channel/UC-GfszUQ-kV4iMmk5W67mAQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thevoice
   @compname = 'The Voice'
   @comp     = 'NBCTheVoice'
   @incomp   = 'nbcthevoice'
   @comp_url = 'https://www.youtube.com/user/NBCTheVoice'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bachelorette
   @compname = 'Bachelorette'
   @comp     = 'BacheloretteABC'
   @incomp   = 'bacheloretteabc'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def scandal
   @compname = 'Scandal'
   @comp     = 'ScandalABC'
   @incomp   = 'scandalabc'
   @comp_url = 'https://www.youtube.com/channel/UCeGLGp4pnTqL64jY3p0daXA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def downtonabbey
   @compname = 'Downton Abbey'
   @comp     = 'DowntonAbbey'
   @incomp   = 'downtonabbey_official'
   @comp_url = 'https://www.youtube.com/channel/UCSm1kNzkDuHqirriGJMZHJQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def dancingwiththestars
   @compname = 'Dancing With The Stars'
   @comp     = 'DancingABC'
   @incomp   = 'dancingabc'
   @comp_url = 'https://www.youtube.com/user/ABCDWTS'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def americanidol
   @compname = 'American Idol'
   @comp     = 'AmericanIdol'
   @incomp   = 'americanidol'
   @comp_url = 'https://www.youtube.com/user/americanidol'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thementalist
   @compname = 'Mentalist'
   @comp     = 'Mentalist_CBS'
   @incomp   = 'mentalist_cbs'
   @comp_url = 'https://www.youtube.com/user/CBSTheMentalist'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def houseofcards
   @compname = 'House of Cards'
   @comp     = 'HouseofCards'
   @incomp   = 'houseofcards'
   @comp_url = 'https://www.youtube.com/channel/UCos_6s_sPNVZMA2YHeJ7nHg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def transparent
   @compname = 'Transparent'
   @comp     = 'transparent_tv'
   @incomp   = 'transparentamazon'
   @comp_url = 'https://www.youtube.com/channel/UCDHUIuNK2PG9UqXsxoLJxsw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def louie
   @compname = 'Louie'
   @comp     = 'LouieFX'
   @incomp   = 'louieonfx'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def community
   @compname = 'Community'
   @comp     = 'CommunityTV'
   @incomp   = 'communitytv'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def parksandrecreation
   @compname = 'Parks and Recreation'
   @comp     = 'parksandrecnbc'
   @incomp   = 'nbcparksandrec'
   @comp_url = 'https://www.youtube.com/user/nbcParksandRec'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sonsofanarchy
   @compname = 'Sons of Anarchy'
   @comp     = 'SonsofAnarchy'
   @incomp   = 'soafx'
   @comp_url = 'https://www.youtube.com/channel/UCp-omzXg5JOqQJQErHhUhrw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brooklynninenine
   @compname = 'Brooklyn 9-9'
   @comp     = 'Brooklyn99FOX'
   @incomp   = 'brooklyn99fox'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def fargo
   @compname = 'Fargo'
   @comp     = 'FargoFX'
   @incomp   = 'fargo'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def saturdaynightlive
   @compname = 'Saturday Night Live'
   @comp     = 'nbcsnl'
   @incomp   = 'nbcsnl'
   @comp_url = 'https://www.youtube.com/user/SaturdayNightLive'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def mrrobot
   @compname = 'Mr. Robot'
   @comp     = 'whoismrrobot'
   @incomp   = 'whoismrrobot'
   @comp_url = 'https://www.youtube.com/channel/UCX5R2xqZWND8nJqGTvel3nw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def themindyproject
   @compname = 'The Mindy Project'
   @comp     = 'TheMindyProject'
   @incomp   = 'mindyprojecthulu'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newgirl
   @compname = 'New Girl'
   @comp     = 'NewGirlonFOX'
   @incomp   = 'newgirlfox'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def scorpion
   @compname = 'Scorpion'
   @comp     = 'ScorpionCBS'
   @incomp   = 'scorpioncbs'
   @comp_url = 'https://www.youtube.com/user/CBSScorpion'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def modernfamily
   @compname = 'Modern Family'
   @comp     = 'ModernFam'
   @incomp   = 'modernfamily'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def janethevirgin
   @compname = 'Jane The Virgin'
   @comp     = 'CWJaneTheVirgin'
   @incomp   = 'cwjanethevirgin'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

#####SPORTS

  def sports_connector
  end

  def realmadrid
   @compname = 'Real Madrid'
   @comp     = 'realmadrid'
   @incomp   = 'realmadrid'
   @comp_url = 'https://www.youtube.com/user/realmadridcf'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def dallascowboys
   @compname = 'Dallas Cowboys'
   @comp     = 'dallascowboys'
   @incomp   = 'dallascowboys'
   @comp_url = 'https://www.youtube.com/channel/UCdjR8pv3bU7WLRshUMwxDVw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newyorkyankees
   @compname = 'New York Yankees'
   @comp     = 'Yankees'
   @incomp   = 'yankees'
   @comp_url = 'https://www.youtube.com/channel/UCQNgE6-Q5OBvLzhyAmWZItQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def barcelona
   @compname = 'Barcelona'
   @comp     = 'FCBarcelona'
   @incomp   = 'fcbarcelona'
   @comp_url = 'https://www.youtube.com/user/fcbarcelona'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def manchesterunited
   @compname = 'Manchester United'
   @comp     = 'ManUtd'
   @incomp   = 'manchesterunited'
   @comp_url = 'https://www.youtube.com/channel/UCKHRBMEiy-GuV-F7JQbJWLg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def losangeleslakers
   @compname = 'Los Angeles Lakers'
   @comp     = 'Lakers'
   @incomp   = 'lakers'
   @comp_url = 'https://www.youtube.com/user/lakersnationdotcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newenglandpatriots
   @compname = 'New England Patriots'
   @comp     = 'Patriots'
   @incomp   = 'patriots'
   @comp_url = 'https://www.youtube.com/channel/UCF54f0UTZ2ctCDs5yJjDblQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newyorkknicks
   @compname = 'New York Knicks'
   @comp     = 'nyknicks'
   @incomp   = 'nyknicks'
   @comp_url = 'https://www.youtube.com/user/nyknicks'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def losangelesdodgers
   @compname = 'Los Angeles Dodgers'
   @comp     = 'Dodgers'
   @incomp   = 'dodgers'
   @comp_url = 'https://www.youtube.com/channel/UCg_8DdhmyMMxa8Xwbcmm-_w'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def washingtonredskins
   @compname = 'Washington Redskins'
   @comp     = 'Redskins'
   @incomp   = 'redskins'
   @comp_url = 'https://www.youtube.com/user/redskinsdotcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bayernmunich
   @compname = 'Bayern Munich'
   @comp     = 'FCBayern'
   @incomp   = 'fcbayern'
   @comp_url = 'https://www.youtube.com/user/fcbayern'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bostonredsox
   @compname = 'Boston Red Sox'
   @comp     = 'RedSox'
   @incomp   = 'redsox'
   @comp_url = 'https://www.youtube.com/channel/UC3FcTH3wcqNWHx4T6iICz_g'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newyorkgiants
   @compname = 'New York Giants'
   @comp     = 'Giants'
   @incomp   = 'nygiants'
   @comp_url = 'https://www.youtube.com/channel/UCnEubDTRusG-qvohSNyCuWg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def chicagobulls
   @compname = 'Chicago Bulls'
   @comp     = 'chicagobulls'
   @incomp   = 'chicagobulls'
   @comp_url = 'https://www.youtube.com/user/chicagobullsofficial'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sanfranciscogiants
   @compname = 'San Francisco Giants'
   @comp     = 'SFGiants'
   @incomp   = 'sfgiants'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def houstontexans
   @compname = 'Houston Texans'
   @comp     = 'HoustonTexans'
   @incomp   = 'houstontexans'
   @comp_url = 'https://www.youtube.com/channel/UC3fjWR24Ej6EfvMv6Hqq28g'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def chicagocubs
   @compname = 'Chicago Cubs'
   @comp     = 'Cubs'
   @incomp   = 'cubs'
   @comp_url = 'https://www.youtube.com/channel/UCbtkUT23QOxQb1w1aP-tRIA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newyorkjets
   @compname = 'New York Jets'
   @comp     = 'nyjets'
   @incomp   = 'nyjets'
   @comp_url = 'https://www.youtube.com/channel/UCNdo59IgJRskCLP7FBWqe6w'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def philadelphiaeagles
   @compname = 'Philadelphia Eagles'
   @comp     = 'Eagles'
   @incomp   = 'philadelphiaeagles'
   @comp_url = 'https://www.youtube.com/channel/UCaogx6OHpsGg0zuGRKsjbtQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bostonceltics
   @compname = 'Boston Celtics'
   @comp     = 'celtics'
   @incomp   = 'celtics'
   @comp_url = 'https://www.youtube.com/user/bostonceltics'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def chicagobears
   @compname = 'Chicago Bears'
   @comp     = 'ChicagoBears'
   @incomp   = 'chicagobears'
   @comp_url = 'https://www.youtube.com/channel/UCP0Cdc6moLMyDJiO0s-yhbQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def losangelesclippers
   @compname = 'Los Angeles Clippers'
   @comp     = 'LAClippers'
   @incomp   = 'laclippers'
   @comp_url = 'https://www.youtube.com/user/clippers1970'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sanfrancisco49ers
   @compname = 'San Francisco 49ers'
   @comp     = '49ers'
   @incomp   = '49ers'
   @comp_url = 'https://www.youtube.com/user/sanfrancisco49ers'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def baltimoreravens
   @compname = 'Baltimore Ravens'
   @comp     = 'Ravens'
   @incomp   = 'ravens'
   @comp_url = 'https://www.youtube.com/user/baltimoreravens'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brooklynnets
   @compname = 'Brooklyn Nets'
   @comp     = 'BrooklynNets'
   @incomp   = 'brooklynnets'
   @comp_url = 'https://www.youtube.com/user/NBANets'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def denverbroncos
   @compname = 'Denver Broncos'
   @comp     = 'Broncos'
   @incomp   = 'broncos'
   @comp_url = 'https://www.youtube.com/channel/UCe6XsNDeY3pxqXJMc_iheUA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def indianapoliscolts
   @compname = 'Indianapolis Colts'
   @comp     = 'Colts'
   @incomp   = 'colts'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def stlouiscardinals
   @compname = 'St. Louis Cardinals'
   @comp     = 'Cardinals'
   @incomp   = 'cardinals'
   @comp_url = 'https://www.youtube.com/channel/UCYPeuBXCeFOq5QfhEnUfr8A'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def greenbaypackers
   @compname = 'Greenbay Packers'
   @comp     = 'packers'
   @incomp   = 'packers'
   @comp_url = 'https://www.youtube.com/channel/UC_C4jeUvhqbsOFCCMql5sHg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def chelsea
   @compname = 'Chelsea'
   @comp     = 'ChelseaFC'
   @incomp   = 'chelseafc'
   @comp_url = 'https://www.youtube.com/user/chelseafc'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ferrari
   @compname = 'Ferrari'
   @comp     = 'Ferrari'
   @incomp   = 'ferrariusa'
   @comp_url = 'https://www.youtube.com/user/ferrariworld'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newyorkmets
   @compname = 'New York Mets'
   @comp     = 'Mets'
   @incomp   = 'mets'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def pittsburghsteelers
   @compname = 'Pittsburgh Steelers'
   @comp     = 'steelers'
   @incomp   = 'steelers'
   @comp_url = 'https://www.youtube.com/channel/UCR6rBAe6fuKAJjdg4dbAcqg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def seattleseahawks
   @compname = 'Seattle Seahawks'
   @comp     = 'Seahawks'
   @incomp   = 'seahawks'
   @comp_url = 'https://www.youtube.com/user/seahawksdotcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def arsenal
   @compname = 'Arsenal'
   @comp     = 'Arsenal'
   @incomp   = 'arsenal'
   @comp_url = 'https://www.youtube.com/user/ArsenalTour'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def goldenstatewarriors
   @compname = 'Golden State Warriors'
   @comp     = 'warriors'
   @incomp   = 'warriors'
   @comp_url = 'https://www.youtube.com/user/GoldenStateWarriors'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def losangelesangelsofanaheim
   @compname = 'Angels of Anaheim'
   @comp     = 'Angels'
   @incomp   = 'angels'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def miamidolphins
   @compname = 'Miami Dolphins'
   @comp     = 'MiamiDolphins'
   @incomp   = 'miamidolphins'
   @comp_url = 'https://www.youtube.com/channel/UCdbljRu3B3WIYliBJat_wsg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def torontomapleleafs
   @compname = 'Toronto Maple Leafs'
   @comp     = 'MapleLeafs'
   @incomp   = 'mapleleafs'
   @comp_url = 'https://www.youtube.com/user/torontomapleleafs'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def washingtonnationals
   @compname = 'Washington Nationals'
   @comp     = 'Nationals'
   @incomp   = 'nationals'
   @comp_url = 'https://www.youtube.com/channel/UCQh28Q2ew4jVoNcDyRygeBw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def carolinapanthers
   @compname = 'Carolina Panthers'
   @comp     = 'Panthers'
   @incomp   = 'panthers'
   @comp_url = 'https://www.youtube.com/channel/UCDmv5BcYE3hQW354jk9W0Cg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def houstonrockets
   @compname = 'Houston Rockets'
   @comp     = 'HoustonRockets'
   @incomp   = 'houstonrockets'
   @comp_url = 'https://www.youtube.com/channel/UCmjAHvW8SC7vmhCFomfyV7Q'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def philadelphiaphillies
   @compname = 'Philadelphia Phillies'
   @comp     = 'Phillies'
   @incomp   = 'phillies'
   @comp_url = 'https://www.youtube.com/channel/UCQh91_NPlNSpWWfqcVLUMTQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tampabaybuccaneers
   @compname = 'Tampa Bay Buccaneers'
   @comp     = 'TBBuccaneers'
   @incomp   = 'tbbuccaneers'
   @comp_url = 'https://www.youtube.com/channel/UC_DXo-lcvFwMWCYNgHP4_tg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def texasrangers
   @compname = 'Texas Rangers'
   @comp     = 'Rangers'
   @incomp   = 'rangers'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def miamiheat
   @compname = 'Miami Heat'
   @comp     = 'MiamiHEAT'
   @incomp   = 'miamiheat'
   @comp_url = 'https://www.youtube.com/user/miamiheat'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tennesseetitans
   @compname = 'Tennessee Titans'
   @comp     = 'Titans'
   @incomp   = 'tennesseetitans'
   @comp_url = 'https://www.youtube.com/channel/UCZIg4NlOuW_ReCVVZ64eLlw'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def atlantabraves
   @compname = 'Atlanta Braves'
   @comp     = 'Braves'
   @incomp   = 'braves'
   @comp_url = 'https://www.youtube.com/channel/UCglKlWno0PXtVhWWQLyQyPQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def minnesotavikings
   @compname = 'Minnesota Vikings'
   @comp     = 'Vikings'
   @incomp   = 'vikings'
   @comp_url = 'https://www.youtube.com/channel/UCSb9A1uBRGUHfSyKCrhfXYA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def arizonacardinals
   @compname = 'Arizona Cardinals'
   @comp     = 'AZCardinals'
   @incomp   = 'azcardinals'
   @comp_url = 'https://www.youtube.com/channel/UC9YrTlASDs12N2SosBvl8tQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def manchestercity
   @compname = 'Manchester City'
   @comp     = 'MCFC'
   @incomp   = 'mcfcofficial'
   @comp_url = 'https://www.youtube.com/user/mcfcofficial'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def music_connector
  end

  def onedirection
   @compname = 'One Direction'
   @comp     = 'onedirection'
   @incomp   = 'onedirection'
   @comp_url = 'https://www.youtube.com/user/OneDirectionVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def katyperrymusic
   @compname = 'Katy Perry'
   @comp     = 'katyperry'
   @incomp   = 'katyperry'
   @comp_url = 'https://www.youtube.com/user/KatyPerryVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def beyoncemusic
   @compname = 'Beyonce'
   @comp     = 'Beyonce'
   @incomp   = 'beyonce'
   @comp_url = 'https://www.youtube.com/user/beyonceVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def taylorswiftmusic
   @compname = 'Taylor Swift'
   @comp     = 'taylorswift13'
   @incomp   = 'taylorswift'
   @comp_url = 'https://www.youtube.com/user/TaylorSwiftVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def justintimberlakemusic
   @compname = 'Justin Timberlake'
   @comp     = 'jtimberlake'
   @incomp   = 'justintimberlake'
   @comp_url = 'https://www.youtube.com/user/justintimberlakeVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def iggyazalea
   @compname = 'Iggy Azalea'
   @comp     = 'IGGYAZALEA'
   @incomp   = 'thenewclassic'
   @comp_url = 'https://www.youtube.com/user/iggyazaleamusicVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def arianagrandemusic
   @compname = 'Ariana Grande'
   @comp     = 'ArianaGrande'
   @incomp   = 'arianagrande'
   @comp_url = 'https://www.youtube.com/user/ArianaGrandeVevo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def mileycyrus
   @compname = 'Miley Cyrus'
   @comp     = 'MileyCyrus'
   @incomp   = 'mileycyrus'
   @comp_url = 'https://www.youtube.com/user/MileyCyrusVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def pharrelwilliams
   @compname = 'Pharrell Williams'
   @comp     = 'Pharrell'
   @incomp   = 'pharrell'
   @comp_url = 'https://www.youtube.com/user/PharrellWilliamsVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def eminem
   @compname = 'Eminem'
   @comp     = 'Eminem'
   @incomp   = 'eminem'
   @comp_url = 'https://www.youtube.com/user/EminemVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def lorde
   @compname = 'Lorde'
   @comp     = 'lordemusic'
   @incomp   = 'lordemusic'
   @comp_url = 'https://www.youtube.com/user/LordeVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def lukebryan
   @compname = 'Luke Bryan'
   @comp     = 'LukeBryanOnline'
   @incomp   = 'lukebryan'
   @comp_url = 'https://www.youtube.com/user/LukeBryanVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def samsmith
   @compname = 'Sam Smith'
   @comp     = 'samsmithworld'
   @incomp   = 'samsmithworld'
   @comp_url = 'https://www.youtube.com/user/SamSmithWorldVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def johnlegend
   @compname = 'John Legend'
   @comp     = 'johnlegend'
   @incomp   = 'johnlegend'
   @comp_url = 'https://www.youtube.com/user/johnlegendVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def onerepublic
   @compname = 'One Republic'
   @comp     = 'OneRepublic'
   @incomp   = 'onerepublic'
   @comp_url = 'https://www.youtube.com/user/OneRepublicVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def drake
   @compname = 'Drake'
   @comp     = 'Drake'
   @incomp   = 'leaderofnewschool'
   @comp_url = 'https://www.youtube.com/user/DrakeVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jasonderulo
   @compname = 'Jason Derulo'
   @comp     = 'jasonderulo'
   @incomp   = 'jasonderulo'
   @comp_url = 'https://www.youtube.com/user/JasonDerulo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def justinbieber
   @compname = 'Justin Bieber'
   @comp     = 'justinbieber'
   @incomp   = 'justinbieber'
   @comp_url = 'https://www.youtube.com/user/JustinBieberVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def imaginedragons
   @compname = 'Imagine Dragons'
   @comp     = 'imaginedragons'
   @incomp   = 'imaginedragons'
   @comp_url = 'https://www.youtube.com/user/ImagineDragonsVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def floridageorgialine
   @compname = 'Florida Georgia Line'
   @comp     = 'FLAGALine'
   @incomp   = 'flagaline'
   @comp_url = 'https://www.youtube.com/user/FlaGeorgiaLineVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nickiminajmusic
   @compname = 'Nicki Minaj'
   @comp     = 'NICKIMINAJ'
   @incomp   = 'nickiminaj'
   @comp_url = 'https://www.youtube.com/user/NickiMinajAtVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def secondsofsummer
   @compname = '5 Seconds of Summer'
   @comp     = '5SOS'
   @incomp   = '5sos'
   @comp_url = 'https://www.youtube.com/user/5sosvevo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ladygagamusic
   @compname = 'Lady Gaga'
   @comp     = 'ladygaga'
   @incomp   = 'ladygaga'
   @comp_url = 'https://www.youtube.com/user/LadyGagaVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def pitbull
   @compname = 'Pitbull'
   @comp     = 'pitbull'
   @incomp   = 'pitbull'
   @comp_url = 'https://www.youtube.com/user/PitbullVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brunomarsmusic
   @compname = 'Bruno Mars'
   @comp     = 'BrunoMars'
   @incomp   = 'brunomars'
   @comp_url = 'https://www.youtube.com/user/ElektraRecords'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def jasonaldean
   @compname = 'Jason Aldean'
   @comp     = 'Jason_Aldean'
   @incomp   = 'jasonaldean'
   @comp_url = 'https://www.youtube.com/user/Jason_Aldean'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def maroon5
   @compname = 'Maroon 5'
   @comp     = 'maroon5'
   @incomp   = 'maroon5'
   @comp_url = 'https://www.youtube.com/user/Maroon5VEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def chrisbrown
   @compname = 'Chris Brown'
   @comp     = 'chrisbrown'
   @incomp   = 'chrisbrownofficial'
   @comp_url = 'https://www.youtube.com/user/ChrisBrownVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def meghantrainor
   @compname = 'Meghan Trainor'
   @comp     = 'Meghan_Trainor'
   @incomp   = 'meghan_trainor'
   @comp_url = 'https://www.youtube.com/user/MeghanTrainorVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bastille
   @compname = 'Bastille'
   @comp     = 'bastilledan'
   @incomp   = 'bastilledan'
   @comp_url = 'https://www.youtube.com/user/BastilleVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def avicii
   @compname = 'Avicii'
   @comp     = 'Avicii'
   @incomp   = 'avicii'
   @comp_url = 'https://www.youtube.com/user/AviciiOfficialVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def magic
   @compname = 'Magic!'
   @comp     = 'ournameisMAGIC'
   @incomp   = 'ournameismagic'
   @comp_url = 'https://www.youtube.com/user/ournameismagicVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def demilovatomusic
   @compname = 'Demi Lovato'
   @comp     = 'ddlovato'
   @incomp   = 'ddlovato'
   @comp_url = 'https://www.youtube.com/user/DemiLovatoVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def blakeshelton
   @compname = 'Blake Shelton'
   @comp     = 'blakeshelton'
   @incomp   = 'blakeshelton'
   @comp_url = 'https://www.youtube.com/user/blakeshelton'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def coldplay
   @compname = 'Coldplay'
   @comp     = 'coldplay'
   @incomp   = 'coldplay'
   @comp_url = 'https://www.youtube.com/user/ColdplayVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def charlixcx
   @compname = 'Charli XCX'
   @comp     = 'charli_xcx'
   @incomp   = 'charli_xcx'
   @comp_url = 'https://www.youtube.com/user/officialcharlixcx'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nicoandvinz
   @compname = 'Nico & Vinz'
   @comp     = 'NicoandVinz'
   @incomp   = 'nicoandvinz'
   @comp_url = 'https://www.youtube.com/user/envymusicchannel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def therollingstones
   @compname = 'The Rolling Stones'
   @comp     = 'RollingStones'
   @incomp   = 'therollingstones'
   @comp_url = 'https://www.youtube.com/user/TheRollingStones'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def shakiramusic
   @compname = 'Shakira'
   @comp     = 'shakira'
   @incomp   = 'shakira'
   @comp_url = 'https://www.youtube.com/user/shakiraVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def passenger
   @compname = 'Passenger'
   @comp     = 'passengermusic'
   @incomp   = 'passengermusic'
   @comp_url = 'https://www.youtube.com/user/passengermusic'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def brantleygilbert
   @compname = 'Brantley Gilbert'
   @comp     = 'BrantleyGilbert'
   @incomp   = 'brantleygilbert'
   @comp_url = 'https://www.youtube.com/user/BrantleyGilbertVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def elliegoulding
   @compname = 'Ellie Goulding'
   @comp     = 'elliegoulding'
   @incomp   = 'elliegoulding'
   @comp_url = 'https://www.youtube.com/user/EllieGouldingVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ericchurch
   @compname = 'Eric Church'
   @comp     = 'ericchurch'
   @incomp   = 'ericchurchmusic'
   @comp_url = 'https://www.youtube.com/user/EricChurchVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def idinamenzel
   @compname = 'Idina Menzel'
   @comp     = 'idinamenzel'
   @incomp   = 'idinamenzel'
   @comp_url = 'https://www.youtube.com/user/Idinamenzel'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def selenagomezmusic
   @compname = 'Selena Gomez'
   @comp     = 'selenagomez'
   @incomp   = 'selenagomez'
   @comp_url = 'https://www.youtube.com/user/SelenaGomezVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def calvinharris
   @compname = 'Calvin Harris'
   @comp     = 'CalvinHarris'
   @incomp   = 'calvinharris'
   @comp_url = 'https://www.youtube.com/user/CalvinHarrisVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def michaelbuble
   @compname = 'Michael Buble'
   @comp     = 'michaelbuble'
   @incomp   = 'michaelbuble'
   @comp_url = 'https://www.youtube.com/user/MichaelBubleTV'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def michaeljackson
   @compname = 'Michael Jackson'
   @comp     = 'michaeljackson'
   @incomp   = 'michaeljackson'
   @comp_url = 'https://www.youtube.com/user/michaeljacksonVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def britneyspearsmusic
   @compname = 'Britney Spears'
   @comp     = 'britneyspears'
   @incomp   = 'britneyspears'
   @comp_url = 'https://www.youtube.com/user/BritneySpearsVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def kellyclarkson
   @compname = 'Kelly Clarkson'
   @comp     = 'kelly_clarkson'
   @incomp   = 'kellyclarkson'
   @comp_url = 'https://www.youtube.com/user/kellyclarksonVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def christinaaguileramusic
   @compname = 'Christinaa Guilera'
   @comp     = 'xtina'
   @incomp   = 'xtina'
   @comp_url = 'https://www.youtube.com/user/CAguileraVEVO'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  ####FOoD
  def food_connector
  end

  def allrecipes
   @compname = 'All Recipes'
   @comp     = 'Allrecipes'
   @incomp   = 'allrecipes'
   @comp_url = 'https://www.youtube.com/user/allrecipes'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cookingdotcom
   @compname = 'Cooking.com'
   @comp     = 'CookingCom'
   @incomp   = 'cookingcom'
   @comp_url = 'https://www.youtube.com/user/cookingcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def foodnetwork
   @compname = 'Food Network'
   @comp     = 'FoodNetwork'
   @incomp   = 'foodnetwork'
   @comp_url = 'https://www.youtube.com/user/FoodNetworkTV'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thekitchn
   @compname = 'The Kitchn'
   @comp     = 'thekitchn'
   @incomp   = 'thekitchn'
   @comp_url = 'https://www.youtube.com/channel/UCuNKgYLb0wOoMvclzSlBvbQ'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def opentable
   @compname = 'Open Table'
   @comp     = 'OpenTable'
   @incomp   = 'opentable'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tasteofhome
   @compname = 'Taste Of Home'
   @comp     = 'tasteofhome'
   @incomp   = 'tasteofhome'
   @comp_url = 'https://www.youtube.com/user/tasteofhome'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def epicurious
   @compname = 'Epicurious'
   @comp     = 'epicurious'
   @incomp   = 'epicurious'
   @comp_url = 'https://www.youtube.com/user/epicuriousdotcom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def grubhub
   @compname = 'Grub Hub'
   @comp     = 'GrubHub'
   @incomp   = 'grubhub'
   @comp_url = 'https://www.youtube.com/user/grubhub'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def seamless
   @compname = 'Seamless'
   @comp     = 'Seamless'
   @incomp   = 'eatseamless'
   @comp_url = 'https://www.youtube.com/user/eatseamless'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def yummly
   @compname = 'Yummly'
   @comp     = 'yummly'
   @incomp   = 'yummly'
   @comp_url = 'https://www.youtube.com/user/Yummly1'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def huffingtonpostfood
   @compname = 'Huffington Post Food'
   @comp     = 'HuffPostFood'
   @incomp   = 'huffpostfood'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def fooddotcom
   @compname = 'Food.com'
   @comp     = 'Fooddotcom'
   @incomp   = 'fooddotcom'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bonappetit
   @compname = 'BonAppetit.com'
   @comp     = 'bonappetit'
   @incomp   = 'bonappetitmag'
   @comp_url = 'https://www.youtube.com/user/BonAppetitDotCom'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def weightwatchers
   @compname = 'Weight Watchers'
   @comp     = 'WeightWatchers'
   @incomp   = 'weightwatchers'
   @comp_url = 'https://www.youtube.com/user/WeightWatchers'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def foodandwine
   @compname = 'Food And Wine'
   @comp     = 'FoodAndWineMag'
   @incomp   = 'foodandwine'
   @comp_url = 'https://www.youtube.com/user/foodandwinevideo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def thechew
   @compname = 'The Chew'
   @comp     = 'thechew'
   @incomp   = 'abcthechew'
   @comp_url = 'https://www.youtube.com/channel/UC-Hz_loYacm45SBtSVA0lRA'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def americastestkitchen
   @compname = 'Americas Test Kitchen'
   @comp     = 'TestKitchen'
   @incomp   = 'testkitchen'
   @comp_url = 'https://www.youtube.com/user/americastestkitchen'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def ironchefamerica
   @compname = 'Iron Chef America'
   @comp     = 'IronChefAmerica'
   @incomp   = 'ironchefamericacuisine'
   @comp_url = 'https://www.youtube.com/channel/UCoag6CfTHLeHuqtCpvo7o7Q'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  ######TRAVEL

  def travel_connector
  end

  def budgettravel
   @compname = 'Budget Travel'
   @comp     = 'BudgetTravel'
   @incomp   = 'budgettravel'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def afar
   @compname = 'Afar'
   @comp     = 'AFARmedia'
   @incomp   = 'afarmedia'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def travelandleisure
   @compname = 'Travel and Leisure'
   @comp     = 'TravelLeisure'
   @incomp   = 'travelandleisure'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def condenasttraveler
   @compname = 'Condenast Traveler'
   @comp     = 'CNTraveler'
   @incomp   = 'cntraveler'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def geographical
   @compname = 'Geographical'
   @comp     = 'GeographicalMag'
   @incomp   = 'geographical_magazine'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def nationalgeographic
   @compname = 'NatGeo'
   @comp     = 'NatGeo'
   @incomp   = 'natgeotravel'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def wanderlust
   @compname = 'Wanderlust'
   @comp     = 'WanderlustFest'
   @incomp   = 'wanderlustfest'
   @comp_url = 'https://www.youtube.com/user/blank'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end
end      


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