module Search
	class Timeline
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  def persisted?
    false
  end

  attr_accessor :params, :search
    USERNAME = /^\B@\w*[a-zA-Z]/
    HASHTAG = /^\B#\w*[a-zA-Z]/

    def initialize(search)
      @search = search
    end

    def construct(params)
      self.params = params
      tw = twitter_setup
      yt = youtube_setup
      ig = instagram_setup
      # fb = facebook_setup
      PostConcatenator.merge(yt, tw, ig)#, fb
    end

   private
 
    def twitter_setup
      client = Twitter::REST::Client.new do |i|
        i.consumer_key = ENV['twitter_api_key']
        i.consumer_secret = ENV['twitter_api_secret']
      end
      if !!(@search =~ USERNAME) #Searches by @username and then deletes the '@'
        search = @search.gsub(/[^0-9A-Za-z]/, '')#deletes all special characters and spaces
        begin
          posts = client.user_timeline(search)
        rescue
          posts = client.search(search, lang: "en", result_type: "popular")
        end
        posts.take(25)
      elsif !!(@search =~ HASHTAG)#Searches by #hashtag and then deletes the '#'
        search = @search.gsub(/[^0-9A-Za-z]/, '')#deletes all special characters and spaces
        posts = client.search(search, lang: "en", result_type: "popular")
        posts.take(50)#result_type: "recent, "
      else
        begin
          search = @search.gsub(/[^0-9A-Za-z]/, '')# general user search without spaces
          posts = client.user_timeline(search)
          posts.take(25)
        rescue 
          search = @search.gsub(/[^0-9A-Za-z+\s]/, '')# general post search with spaces
          posts = client.search(search, lang: "en", result_type: "popular")
          posts.take(50)
        else
          search = @search.gsub(/[^0-9A-Za-z]/, '')# general post search without spaces
          posts = client.search(search, lang: "en", result_type: "popular")
          posts.take(50)
        # ensure
        #   posts = client.user_timeline('nfuse01').take(25)
        end
      end
       posts.map { |post| Search::Entry.from(post, 'twitter') }
    end

    def youtube_setup
      Yt.configure do |config|
        config.client_id = ENV['google_client_id']
        config.client_secret = ENV['google_client_secret']
        config.api_key = ENV['youtube_dev_key']
      end
      #Yt.configuration.api_key = ENV['api_key']
      if !!(@search =~ USERNAME) #Searches by @username and then deletes the '@'
        search = @search.gsub(/[^0-9A-Za-z]/, '')#deletes all special characters and spaces
        # client = Oj.load(Faraday.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{search}&key=#{ENV['api_key']}").body)
        begin
         client = Oj.load(Faraday.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{search}&key=#{ENV['api_key']}").body)
          # if client['items'][0]['snippet']['channelTitle'].present?
          begin
            usid = client['items'][0]['snippet']['channelTitle']
            channel = Yt::Channel.new url: "https://www.youtube.com/user/#{usid}"#can't search youtube channels with spaces in the search params 
            posts = channel.videos.where(order: "viewCount").first(15)
          rescue
            usid = client['items'][0]['id']['channelId']
            channel = Yt::Channel.new url: "https://www.youtube.com/channel/#{usid}"
            posts = channel.videos.where(order: "viewCount").first(15)
          end
        rescue
          videos = Yt::Collections::Videos.new
          posts = videos.where(q: search, order: "viewCount").first(15)
        end
        # posts = channel.videos.where(order: "viewCount").first(15)
      elsif !!(@search =~ HASHTAG)#Searches by #hashtag and then deletes the '#'
        search = @search.gsub(/[^0-9A-Za-z]/, '')#deletes all special characters and spaces
        videos = Yt::Collections::Videos.new
        posts = videos.where(q: search, order: "viewCount").first(15) #uid = videos.where(q: search).first(15).m
        #posts = Oj.load(Faraday.get("https://www.googleapis.com/youtube/v3/videos?id=#{uids}&key=#{ENV['api_key']}&part=snippet,contentDetails,statistics").body)
      else
        begin
          search = @search.gsub(/[^0-9A-Za-z]/, '')# general user search without spaces
          client = Oj.load(Faraday.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{search}&key=#{ENV['api_key']}").body)

          if client['items'][0]['snippet']['channelTitle'].present?
            usid = client['items'][0]['snippet']['channelTitle']
            channel = Yt::Channel.new url: "https://www.youtube.com/user/#{usid}"#can't search youtube channels with spaces in the search params 
          else
            usid = client['items'][0]['id']['channelId']
            channel = Yt::Channel.new url: "https://www.youtube.com/channel/#{usid}"
          end
          posts = channel.videos.where(order: "viewCount").first(15)
        rescue 
          search = @search.gsub(/[^0-9A-Za-z+\s]/, '')# general post search with spaces
          videos = Yt::Collections::Videos.new
          posts = videos.where(q: search, order: "viewCount").first(15)
        else
          search = @search.gsub(/[^0-9A-Za-z]/, '')# general post search without spaces
          videos = Yt::Collections::Videos.new
          posts = videos.where(q: search, order: "viewCount").first(15)
        # ensure
        #   posts = client.user_timeline('nfuse01').take(25)
        end        
      end
      posts.map { |post| Search::Entry.from(post, 'youtube')}
    end

    def instagram_setup
      client_id = ENV['instagram_client_id']
      if !!(@search =~ USERNAME) #Searches by @username and then deletes the '@'
        begin
          search = @search.gsub(/[^0-9A-Za-z+\s]/, '')#deletes all special characters and spaces
          client = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{search}&client_id=#{client_id}").body)
          begin
            usid = client['data'][0]['id']
            posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=25").body)
            posts['data'].map { |post| Search::Entry.from(post,'instagram') }
          rescue
            usid = client['data'][1]['id']
            posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=25").body)
            posts['data'].map { |post| Search::Entry.from(post,'instagram') }
          end
        rescue
          search = @search.gsub(/[^0-9A-Za-z]/, '')
          posts = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/#{search}/media/recent?client_id=#{client_id}&count=25").body)
          posts['data'].map { |post| Search::Entry.from(post,'instagram') }
        end
      elsif !!(@search =~ HASHTAG)#Searches by #hashtag and then deletes the '#'
        search = @search.gsub(/[^0-9A-Za-z]/, '')#deletes all special characters and spaces
        posts = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/#{search}/media/recent?client_id=#{client_id}&count=25").body)
        posts['data'].map { |post| Search::Entry.from(post,'instagram') }
      else
        begin
          search = @search.gsub(/[^0-9A-Za-z]/, '')# general user search without spaces
          client = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{search}&client_id=#{client_id}").body)
          begin
            usid = client['data'][0]['id']
            posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=25").body)
            posts['data'].map { |post| Search::Entry.from(post,'instagram') }
          rescue
            usid = client['data'][1]['id']
            posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=25").body)
            posts['data'].map { |post| Search::Entry.from(post,'instagram') }
          end
        rescue
          search = @search.gsub(/[^0-9A-Za-z]/, '')# general post search with spaces
          posts = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/#{search}/media/recent?client_id=#{client_id}&count=25").body)
          posts['data'].map { |post| Search::Entry.from(post,'instagram') }
        # else
        #   search = @search.gsub(/[^0-9A-Za-z+\s]/, '')# general post search without spaces
        #   posts = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/#{search}/media/recent?client_id=#{client_id}&count=25").body)
        #   posts['data'].map { |post| Post::Entry.from(post,'instagram') }
        end
      end
    end

    # Facebook Needs an oauth token to be able to let users search content
    # Trying oauth.io generated token to test fb
    def facebook_setup
      app_secret = ENV['app_secret']
      auth_token = ENV['faccess_token']
      client = Koala::Facebook::API.new(auth_token, app_secret)
      posts = client.get_connections(@search, 'posts' )
      posts.map { |post| Post::Entry.from(post, 'facebook') }
    end
	end
end

class PostConcatenator
  def self.merge(twitter_setup, youtube_setup, instagram_setup)#, facebook_setup
    (youtube_setup + instagram_setup + twitter_setup ).sort_by { |post| post.created_time }.reverse# # + facebook_setup like_count
  end
end
