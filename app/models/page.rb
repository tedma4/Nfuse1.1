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
    ActsAsVotable::Vote.where('created_at <= ? and owner_type = ? and votable_type is ?', 1.week.ago, 'User', nil).group('votable_id')
  end
  
  def self.trending_twitter_posts
    client = Twitter::REST::Client.new do |i|
      i.consumer_key = ENV['twitter_api_key']
      i.consumer_secret = ENV['twitter_api_secret']
    end
    client
  end

  def self.next_page
    Page.all.shuffle.first.id
  end
end