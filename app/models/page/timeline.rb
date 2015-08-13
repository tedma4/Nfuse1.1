module Page
	class Timeline

    def posts
      timeline = PageConcatenator.new.merge()
      timeline
    end

   private

    def comp_posts(comp)
      comp_posts = []
      comp_timeline = Page::Timeline.new(comp)
      comp_posts = comp_timeline.posts.map { |post| Page::Post.from(post) }
      comp_posts
    end
 
    def twitter_setup(comp)
     client = Twitter::REST::Client.new do |i|
       i.consumer_key = ENV['twitter_api_key']
       i.consumer_secret = ENV['twitter_api_secret']
     end
     posts = client.user_timeline(comp).take(25)
    end
 
    def youtube_setup(comp_url)
     Yt.configuration.api_key = ENV['youtube_dev_key']
     channel = Yt::Channel.new url: comp_url
     posts = channel.videos.first(15)
    end
 
    def instagram_setup(comp)
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
end

class PageConcatenator
  def merge(twitter_setup, youtube_setup, instagram_setup)
    (twitter_setup + youtube_setup + instagram_setup).sort_by { |post| post.created_time }.reverse
  end
end