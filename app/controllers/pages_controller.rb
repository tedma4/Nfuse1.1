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
   @comp_url = 'https://www.youtube.com/user/TiffanyAndCo'
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
   @comp_url = 'https://www.youtube.com/user/guccioffical'
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

  def business_connector
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
end
# To perform GET on "https://api.instagram.com/v1/users/<user-id>/media/recent/" 

# You can perform "https://api.instagram.com/v1/users/[USER ID]/media/recent/?client_id=[CLIENT ID]"

# [CLIENT ID] would be valid client id registered in app through manage clients 
# (not related to user whatsoever). You can get [USER ID] from username 
# by performing GET users search request: "https://api.instagram.com/v1/users/search?q=[USERNAME]&client_id=[CLIENT ID]"

# first search by username(companys username) and get user_id from the search
# next, use the recieved user_id to get the recent media of said company 
# https://api.instagram.com/v1/users/search?q=wired&client_id=d5a97c3cf7b04c70ae234eb9933ef2fd

# "https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}"
