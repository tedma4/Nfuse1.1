module Biz
	class Timeline
  attr_accessor :params
  require 'thread'
    def initialize(page)
      @page = page
    end
    
    def construct(params)
      self.params = params
      concurrency_test_with_thread
    end

   private
 
   def concurrency_test_with_thread
     list = [['twitter', @page.twitter_handle], ['google_oauth2', @page.youtube_handle], ['instagram', @page.instagram_handle]]
     threads = []
     list.each do |this|
       if list.flatten[1].include?('blank') && list.flatten[3].include?('blank') && this.first == 'instagram'
         threads << Thread.new { instance_variable_set("@#{this.first}", self.send("#{this.first}_setup", true, *this))}
       elsif this.second.include?('blank')
          #Do nothing for blank biz accounts for now
       else
         threads << Thread.new { instance_variable_set("@#{this.first}", self.send("#{this.first}_setup", false, *this))}
       end
     end
     threads.each(&:join)
     merge = []
     list.each do |it|
       if instance_variable_get("@#{it.first}").nil?
         #leaving this blank for now
       elsif it.first == 'instagram'
         begin
           merge << instance_variable_get("@#{it.first}")['data'].map { |post| Biz::Post.from(post, "#{it.first}", @page)}
         rescue
          #Leaving blank till i find out what to do with it
         end
       else
         begin
           merge << instance_variable_get("@#{it.first}").map { |post| Biz::Post.from(post, "#{it.first}", @page)}
         rescue
           # Same here
         end
       end
     end
     merge.inject(:+)
     merge
   end

    def twitter_setup(that = false, *this)#, that = false,
      client = twitter_token
      begin
        if that == false
          client.user_timeline(this.second).take(15)
        else
          client.user_timeline(this.second).take(30)
        end
      rescue
        if that == false
          client.user_timeline('LastWeekTonight').take(15)
        else
          client.user_timeline('LastWeekTonight').take(30)
        end
      end
    end
 
    def google_oauth2_setup(that = false, *this)#, that = false
      youtube_token
      begin
        channel = Yt::Channel.new url: this.second
        if that == false
          channel.videos.first(15)
        else
          channel.videos.first(30)
        end
      rescue
        channel = Yt::Channel.new url: 'https://www.youtube.com/user/LastWeekTonight'
        if that == false
          channel.videos.first(15)
        else
          channel.videos.first(30)
        end
      end
    end

    def instagram_setup(that = false, *this)#, that = false
      client_id = instagram_token
      thing = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{this.second}&client_id=#{client_id}").body)
      if thing['data'][0]['username'] == this.second
        usid = thing['data'][0]['id']
        if that == false
          Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=20").body)
        else
          Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}/media/recent/?client_id=#{client_id}&count=50").body)
        end
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
      ENV['instagram_client_id']
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
