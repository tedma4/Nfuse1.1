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
     list = [['twitter', @comp], ['youtube', @comp_url], ['instagram', @incomp]]
     threads = []
     list.each do |this|
       threads << Thread.new { instance_variable_set("@#{this.first}", self.send("#{this.first}_setup", *this))}
     end
     threads.each(&:join)
     merge = []
     list.each do |it|
       if it.first == 'instagram'
         merge << instance_variable_get("@#{it.first}")['data'].map { |post| Biz::Post.from(post, "#{it.first}")}
       else
         merge << instance_variable_get("@#{it.first}").map { |post| Biz::Post.from(post, "#{it.first}")}
       end
     end
     merge.inject(:+)
     merge
   end

    def twitter_setup(*this)
      client = twitter_token
      client.user_timeline(this.second).take(15)
      # posts.map { |post| Biz::Post.from(post, 'twitter') }
    end
 
    def youtube_setup(*this)
      youtube_token
      channel = Yt::Channel.new url: this.second
      channel.videos.first(15)
      # posts.map { |post| Biz::Post.from(post, 'youtube') }
    end

    def instagram_setup(*this)
      client_id = instagram_token
      thing = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{this.second}&client_id=#{client_id}").body)
      if thing['data'][0]['username'] == this.second
        usid = thing['data'][0]['id']
        Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=20").body)
        # posts['data'].map { |post| Biz::Post.from(post,'instagram') }
       else
         []
      end
    end

    def twitter_token
      Twitter::REST::Client.new do |i|
        i.consumer_key = ENV['twitter_api_key']
        i.consumer_secret = ENV['twitter_api_secret']
      end
    end

    def instagram_token
      client_id = ENV['instagram_client_id']
    end

    def youtube_token
      Yt.configuration.api_key = ENV['youtube_dev_key']
    end
	end
end


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
