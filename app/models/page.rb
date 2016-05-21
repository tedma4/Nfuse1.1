class Page < ActiveRecord::Base
  is_impressionable :counter_cache => true, :column_name => :page_counter_cache
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, source: :users, through: :relationships
  has_many :comments, as: :commentable, dependent: :destroy
  def self.search(search)
    conditions = []
    search_columns = [ :page_name ]
    search.split(' ').each do |word|
      search_columns.each do |column|
        conditions << " lower(#{column}) LIKE lower(#{sanitize("%#{word}%")}) "
      end
    end
    conditions = conditions.join('OR')    
    self.where(conditions)
  end

  def profile_pic
    client_id = ENV['instagram_client_id']
    thing = Oj.load(Faraday.get("https://api.instagram.com/v1/users/search?q=#{self.instagram_handle}&client_id=#{client_id}").body)
    profile_pic = nil
    begin
      save =  thing['data'].keep_if { |page| page['username'] == self.instagram_handle }
      profile_pic = save[0]['profile_picture']
    rescue
      profile_pic = nil
    end
    # i = 0
    # num = 20
    # until i > num  do
    #   if thing.any? && thing['data'][i]['username'] == self.instagram_handle
    #     # usid = thing['data'][i]['id']
    #     begin
    #       profile_pic = thing['data'][i]['profile_picture']
    #     rescue
    #       "#{self.twitter_handle}.jpg"
    #     end
    #     break
    #   end
    #   puts "wasn't number #{i}, it was #{thing['data'][i]['username']}"
    #   i += 1
    # end
    profile_pic
  end

  def self.trending_user_posts
    ActsAsVotable::Vote.where('created_at >= ? and owner_type = ?', 1.week.ago, 'User').group('votable_id')
  end

  def self.trending_page_posts
    ActsAsVotable::Vote.where('created_at >= ? and owner_type = ?', 1.week.ago, 'Page').group('votable_id')
  end

  def self.trending_nfuse_posts
    ActsAsVotable::Vote.where('created_at >= ? and owner_type = ? and votable_type is ?', 1.week.ago, 'User', nil).group('votable_id')
  end
  
  def self.trending_twitter_posts
    client = Twitter::REST::Client.new do |i|
      i.consumer_key = ENV['twitter_api_key']
      i.consumer_secret = ENV['twitter_api_secret']
    end
    client.search('news', lang: "en", result_type: "popular", limit: 5 ).map { |post| Search::Entry.from(post, 'twitter') }
  end
  
  def self.trending_youtube_posts
    Yt.configure do |config|
      config.client_id = ENV['google_client_id']
      config.client_secret = ENV['google_client_secret']
      config.api_key = ENV['youtube_dev_key']
    end
     client = Oj.load(Faraday.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=news&key=#{ENV['youtube_dev_key']}").body)
     videos = Yt::Collections::Videos.new
     videos.where(q: 'news', order: "viewCount").first(15).map { |post| Search::Entry.from(post, 'youtube') }
    # begin
    #  client = Oj.load(Faraday.get("https://www.googleapis.com/youtube/v3/search?part=snippet&q=news&key=#{ENV['youtube_dev_key']}").body)
    #   # if client['items'][0]['snippet']['channelTitle'].present?
    #   begin
    #     usid = client['items'][0]['snippet']['channelTitle']
    #     channel = Yt::Channel.new url: "https://www.youtube.com/user/#{usid}"#can't search youtube channels with spaces in the search params 
    #     posts = channel.videos.where(order: "viewCount").first(15).map { |post| Search::Entry.from(post, 'youtube') }
    #   rescue
    #     usid = client['items'][0]['id']['channelId']
    #     channel = Yt::Channel.new url: "https://www.youtube.com/channel/#{usid}"
    #     posts = channel.videos.where(order: "viewCount").first(15).map { |post| Search::Entry.from(post, 'youtube') }
    #   end
    # rescue
    #   videos = Yt::Collections::Videos.new
    #   videos.where(q: 'news', order: "viewCount").first(15).map { |post| Search::Entry.from(post, 'youtube') }
    # end
  end
  
  def self.trending_instagram_posts
    client_id = ENV['instagram_client_id']
    client = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/search/media/recent?q=news&client_id=#{client_id}&count=5").body)['data'].map { |post| Search::Entry.from(post,'instagram') }
    # begin
    #   client = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/search?q=news&client_id=#{client_id}").body)['data'].map { |post| Search::Entry.from(post,'instagram') }
    #   begin
    #     usid = client['data'][0]['id']
    #     posts = Oj.load(Faraday.get("https://api.instagram.com/v1/media/#{usid}/media/recent/?client_id=#{client_id}&count=5").body)
    #     posts['data'].map { |post| Search::Entry.from(post,'instagram') }
    #   rescue
    #     usid = client['data'][1]['id']
    #     posts = Oj.load(Faraday.get("https://api.instagram.com/v1/media/#{usid}/media/recent/?client_id=#{client_id}&count=5").body)
    #     posts['data'].map { |post| Search::Entry.from(post,'instagram') }
    #   end
    # rescue
    #   search = @search.gsub(/[^0-9A-Za-z]/, '')
    #   posts = Oj.load(Faraday.get("https://api.instagram.com/v1/tags/news/media/recent?client_id=#{client_id}&count=5").body)
    #   posts['data'].map { |post| Search::Entry.from(post,'instagram') }
    # end
  end

  def self.next_page
    Page.all.shuffle.first.id
  end
end