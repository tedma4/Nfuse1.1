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

  def wired_posts
   comp = 'wired'
   comp_url = 'https://www.youtube.com/user/wired'
   twitter_setup
   youtube_setup
   instagram_setup
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

   def twitter_setup
    client = Twitter::REST::Client.new do |i|
      i.consumer_key = ENV['twitter_api_key']
      i.consumer_secret = ENV['twitter_api_secret']
    end
    client.user_timeline(comp).take(25)
   end

   def youtube_setup
    Yt.configuration.api_key = ENV['youtube_dev_key']
    channel = Yt::Channel.new url: comp_url
    channel.videos.first(15)
   end

   def instagram_setup
     client_id = ENV['instagram_client_id']
     client = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{comp}&client_id=#{client_id}").body)
     if client['data'][0]['username'] == comp
       usid = client['data'][0]['id']
       posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}").body)
     else
       []
     end
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
