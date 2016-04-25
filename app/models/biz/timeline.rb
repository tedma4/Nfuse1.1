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
    threads = []
    provider_list.each do |provider|
       if provider_list.flatten[1].nil? && provider_list.flatten[3].nil? && provider.first == 'instagram'
        threads << Thread.new { instance_variable_set("@#{provider.first}", self.send("#{provider.first}_setup", true, *provider))}
      elsif provider.second.nil?
         #Do nothing for blank biz accounts for now
      else
        threads << Thread.new { instance_variable_set("@#{provider.first}", self.send("#{provider.first}_setup", false, *provider))}
      end
    end
    threads.each(&:join)
    merge = []
    provider_list.each do |provider|
      if instance_variable_get("@#{provider.first}").nil?
        #leaving this blank for now
      elsif provider.first == 'instagram'
        begin
          merge << instance_variable_get("@#{provider.first}")['data'].map { |post| Biz::Post.from(post, "#{provider.first}", @page)}
        rescue
         #Leaving blank till i find out what to do with it 
        end
      else
        begin
          if provider.first == 'twitter'
            # twitter_post.attrs[:user][:screen_name] == (twitter_post.attrs[:retweeted_status] ? twitter_post[:retweeted_status][:user][:screen_name] : 'twitter'
            @twitter = @twitter.delete_if { |twitter_post| twitter_post.attrs.has_key?(:retweeted_status) || twitter_post.attrs[:in_reply_to_status_id] != nil }
            merge << @twitter.map { |post| Biz::Post.from(post, "#{provider.first}", @page) }
          else
            merge << instance_variable_get("@#{provider.first}").map { |post| Biz::Post.from(post, "#{provider.first}", @page)}
          end
        rescue
          # Same here
        end
      end
    end
    merge.inject(:+)
    page_posts_and_image = {
      page_feeds: merge,
      page_image: @page.profile_pic
      }
  end

    def provider_list
      [['twitter', @page.twitter_handle], ['google_oauth2', @page.youtube_handle], ['instagram', @page.instagram_handle]]
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
