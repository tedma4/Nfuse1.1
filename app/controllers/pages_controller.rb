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
   @comp     = 'wired'
   @comp_url = 'https://www.youtube.com/user/wired'
   @incomp   = 'wired'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def national_geographic
   @comp     = 'NatGeo'
   @comp_url = 'https://www.youtube.com/user/NationalGeographic'
   @incomp   = 'natgeo'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def people_magazine
   @comp     = 'people'
   @comp_url = 'https://www.youtube.com/user/people'
   @incomp   = 'peoplemag'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def time_magazine
   @comp     = 'TIME'
   @comp_url = 'https://www.youtube.com/user/TimeMagazine'
   @incomp   = 'time'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def sports_illustrated
   @comp     = 'sinow'
   @comp_url = 'https://www.youtube.com/user/SportsIllustrated'
   @incomp   = 'sportsillustrated'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cosmopolitan
   @comp     = 'Cosmopolitan'
   @comp_url = 'https://www.youtube.com/user/HelloStyleChannel'
   @incomp   = 'cosmopolitan'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def redbull
   @comp     = 'redbull'
   @comp_url = 'https://www.youtube.com/user/redbull'
   @incomp   = 'redbull'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def espn
   @comp     = 'espn'
   @comp_url = 'https://www.youtube.com/user/ESPN'
   @incomp   = 'espn'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def us_weekly
   @comp     = 'usweekly'
   @comp_url = 'https://www.youtube.com/user/UsWeekly'
   @incomp   = 'usweekly'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def entertainment_weekly
   @comp     = 'EW'
   @comp_url = 'https://www.youtube.com/user/ew'
   @incomp   = 'entertainmentweekly'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def newsweek
   @comp     = 'Newsweek'
   @comp_url = 'https://www.youtube.com/user/NewsweekVideo'
   @incomp   = 'newsweek'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def popular_science
   @comp     = 'PopSci'
   @comp_url = 'https://www.youtube.com/user/Popscivideo'
   @incomp   = 'popsci'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def vogue
   @comp     = 'vougemagazine'
   @comp_url = 'https://www.youtube.com/user/Americanvogue'
   @incomp   = 'vougemagazine'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def bloomberg_businessweekly
   @comp     = 'business'
   @comp_url = 'https://www.youtube.com/user/Bloomberg'
   @incomp   = 'bloomberg'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def gq
   @comp     = 'GQMagazine'
   @comp_url = 'https://www.youtube.com/user/GQVideos'
   @incomp   = 'gq'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def hgtv
   @comp     = 'hgtv'
   @comp_url = 'https://www.youtube.com/user/HGTV'
   @incomp   = 'hgtv'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def forbes_magazine
   @comp     = 'Forbes'
   @comp_url = 'https://www.youtube.com/user/forbes'
   @incomp   = 'forbes'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def fortune
   @comp     = 'FortuneMagazine'
   @comp_url = 'https://www.youtube.com/user/FortuneMagazineVideo'
   @incomp   = 'fortunemag'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def e_news
   @comp     = 'Enews'
   @comp_url = 'https://www.youtube.com/user/enews'
   @incomp   = 'enews'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def google
   @comp     = 'google'
   @comp_url = 'https://www.youtube.com/user/Google'
   @incomp   = 'google'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tedtalks
   @comp     = 'TEDTalks'
   @comp_url = 'https://www.youtube.com/user/TEDtalksDirector'
   @incomp   = 'ted'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def tesla
   @comp     = 'TeslaMotors'
   @comp_url = 'https://www.youtube.com/user/TeslaMotors'
   @incomp   = 'teslamotors'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def victorias_secret
   @comp     = 'VictoriasSecret'
   @comp_url = 'https://www.youtube.com/user/VICTORIASSECRET'
   @incomp   = 'victoriassecret'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
  end

  def cnn
   @comp     = 'CNN'
   @comp_url = 'https://www.youtube.com/user/CNN'
   @incomp   = 'cnn'
   page     = Page::Timeline.new(@comp, @comp_url, @incomp)
   @timeline = page.construct(params)
   render 'comp'
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
