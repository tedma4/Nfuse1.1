module Biz
	class Timeline
  attr_accessor :params
  require 'thread'
    def initialize(comp, comp_url, incomp)
      @comp = comp
      @comp_url = comp_url
      @incomp = incomp
    end
    
    def construct(params)
      self.params = params
      concurrency_test_with_thread
    end

   private
 
   def concurrency_test_with_thread
     client = twitter_token
     youtube_token
     channel = Yt::Channel.new url: @comp_url
     client_id = instagram_token
     thing = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{@incomp}&client_id=#{client_id}").body)
     if thing['data'].empty?
       usid = "nil"
     else
       usid = thing['data'][0]['id']
     end

     # thingy = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=1").body)
     # posts['data'].map { |post| Biz::Post.from(post,'instagram') }
     #  else
     #    []
     # end
     threads = []
     threads << Thread.new { @twitter_thingy = client.user_timeline(@comp).take(15) }
     threads << Thread.new { @youtube_thingy = channel.videos.first(15) }
     threads << Thread.new { @instagram_thingy = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=20").body) }
     threads.each(&:join)
     # hydra = Typhoeus::Hydra.hydra
     # first = Typhoeus::Request.new(@twitter_thingy = client.user_timeline(@comp).take(15) || [])
     # second = Typhoeus::Request.new(@youtube_thingy = channel.videos.first(15) || [] )
     # third = Typhoeus::Request.new(@instagram_thingy = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=20").body) || [])
     # hydra.queue first
     # hydra.queue second
     # hydra.queue third
     # hydra.run
     merge = (@twitter_thingy.map { |post| Biz::Post.from(post, 'twitter') } +
       @youtube_thingy.map { |post| Biz::Post.from(post, 'youtube') } +
       @instagram_thingy['data'].map { |post| Biz::Post.from(post, 'instagram') }
     )
   end

    def twitter_token
      Twitter::REST::Client.new do |i|
        i.consumer_key = ENV['twitter_api_key']
        i.consumer_secret = ENV['twitter_api_secret']
      end
    end

    def instagram_token
      ENV['instagram_client_id']
    end

    def youtube_token
      Yt.configuration.api_key = ENV['youtube_dev_key']
    end
	end
end
# class BizConcatenator
#   def self.merge(twitter_setup, youtube_setup, instagram_setup)
#     (twitter_setup + youtube_setup + instagram_setup).sort_by { |post| post.created_time }.reverse
#   end
# end


# hydra = Typhoeus::Hydra.new
# requests = 10.times.map {
#   request = Typhoeus::Request.new("www.example.com", followlocation: true)
#   hydra.queue(request)
#   request
# }
# hydra.run

# responses = requests.map { |request|
#   request.response.body
# }



    # def twitter_setup
    #   #twitter_posts = []
    #   client = Twitter::REST::Client.new do |i|
    #     i.consumer_key = ENV['twitter_api_key']
    #     i.consumer_secret = ENV['twitter_api_secret']
    #   end
    #   posts = client.user_timeline(@comp).take(15)
    #   posts.map { |post| Biz::Post.from(post, 'twitter') }
    # end
 
    # def youtube_setup
    #   Yt.configuration.api_key = ENV['youtube_dev_key']
    #   channel = Yt::Channel.new url: @comp_url
    #   posts = channel.videos.first(15)
    #   posts.map { |post| Biz::Post.from(post, 'youtube') }
    # end

    # def instagram_setup
    #   client_id = ENV['instagram_client_id']
    #   thing = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{@incomp}&client_id=#{client_id}").body)
    #   if thing['data'][0]['username'] == @incomp
    #     usid = thing['data'][0]['id']
    #     posts = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=20").body)
    #     posts['data'].map { |post| Biz::Post.from(post,'instagram') }
    #    else
    #      []
    #   end
    # end
    
      # tw = twitter_setup
      # yt = youtube_setup
      # ig = instagram_setup
      # merge = (tw + yt + ig).sort_by { |post| post.created_time }.reverse