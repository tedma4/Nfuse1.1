module Page
	class Timeline
  attr_accessor :params

    def initialize(comp, comp_url, incomp)
      @comp = comp
      @comp_url = comp_url
      @incomp = incomp
    end

    def posts
      PageConcatenator.new.merge(twitter_setup, youtube_setup, instagram_setup)
    end

    def construct(params)
      self.params = params
      tw = twitter_setup
      yt = youtube_setup
      ig = instagram_setup
      PageConcatenator.merge(tw, yt, ig)
    end

   private
 
    def twitter_setup
      #twitter_posts = []
     client = Twitter::REST::Client.new do |i|
       i.consumer_key = ENV['twitter_api_key']
       i.consumer_secret = ENV['twitter_api_secret']
     end
     posts = client.user_timeline(@comp).take(15)
     twitter_posts = posts.map { |post| Page::Post.from(post, 'twitter') }
    end
 
    def youtube_setup
     Yt.configuration.api_key = ENV['youtube_dev_key']
     channel = Yt::Channel.new url: @comp_url
     posts = channel.videos.first(15)
     youtube_posts = posts.map { |post| Page::Post.from(post, 'youtube') }
    end

    def instagram_setup
      client_id = ENV['instagram_client_id']
      client = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{@incomp}&client_id=#{client_id}").body)
      if client['data'][0]['username'] == @incomp
        usid = client['data'][0]['id']
        posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=20").body)
        instagram_posts = posts['data'].map { |post| Page::Post.from(post,'instagram') }
      else
        []
      end
    end
	end
end

class PageConcatenator
  def self.merge(twitter_setup, youtube_setup, instagram_setup)
    (twitter_setup + youtube_setup + instagram_setup).sort_by { |post| post.created_time }.reverse
  end
end