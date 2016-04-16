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
    i = 0
    num = 10
    until i > num  do
      # byebug
      if thing['data'][i]['username'] == self.instagram_handle
        usid = thing['data'][i]['id']
        begin
          profile_pic = Oj.load(Faraday.get("https://api.instagram.com/v1/users/#{usid}?client_id=#{client_id}").body)['data']['profile_picture']
        rescue
          "#{self.twitter_handle}.jpg"
        end
        break
      end
      puts "wasn't number #{i}"
      i += 1
    end
    profile_pic
  end
end


# Until username matches instagram_handle
# break if condition is met or excedes loop limit

# # $i = 0
# # $num = 5

# # until $i > $num  do
# #    puts("Inside the loop i = #$i" )
# #    $i +=1;
# # end

# i = 0
# num = 10
# until i > num  do
#   if thing['data'][$i]['username'] == 'armani'
#     break
#   end
#   i += 1
# end