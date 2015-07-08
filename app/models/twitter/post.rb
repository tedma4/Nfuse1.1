require_relative 'api'

module Twitter
  class Post < TimelineEntry

  attr_reader :user  
  
  include Api

    def self.from(tweet, user)
      new(tweet, user)
    end

    def initialize(tweet, user)
      @tweet = tweet
      @user = user
    end

    # 
    def like_score(id)
      # Implement counter cache per / Records
      ActsAsVotable::Vote.where(votable_id: id).count
    end

    def comment_count(id)
      Comment.where(commentable_id: id).count
    end

    # User Object * because delegate is not working.

    def avatar
      @user.avatar(:thumb)
    end

    def username
      @user.user_name
    end

    def created_time
      @tweet.created_at
    end

    def provider
      "twitter"
    end

    def tweet_id
      @tweet["id"]
    end

    def tweet_user
      @tweet['user']
    end

    #def profile_picture
    #  tweet_user["profile_image_url_https"]
    #end
#
    #def user_name
    #  tweet_user["name"]
    #end
#
    #def screen_name
    #  tweet_user["screen_name"]
    #end

    def tweet_text
      @tweet["text"]
    end

    #def retweet_count
    #  @tweet["retweet_count"].to_i
    #end
#
    #def favorite_count
    #  @tweet["favorite_count"].to_i
    #end

    #def tweet_image
    #  @tweet['media'][0]['media_url'] if @tweet.fetch('media', nil)
    #end

    def tweet_image
      if @tweet["media"].present?
        @tweet["media"][0]["media_url"]
      else
        nil
      end
    end
  end
end


#     def type
#       @tweet['media']
#     end

#     def tweet_image
#       @tweet.media.collect(&:media_url)
#     end
#   end
# end



  # <div class="post_content">
  #   <% if post.type == 'Twitter::Media::Photo' %>
  #   <div class="timeline-user-box">
  #     <%= image_tag(post.tweet_image, :class => "image_post tweeter_image") %>
  #   </div><!-- 
  #   <% #elsif post.type == Twitter::Media::Video %>
  #   <div class="timeline-user-box">
  #     <iframe 
  #       border= '0' 
  #       frameborder= '0' 
  #       height= '225' 
  #       width= '100%' 
  #       src="<%#= post.tweet_image %>">
  #     </iframe>      
  #     <%#= image_tag(post.tweet_image, :class => "image_post tweeter_image") %>
  #   </div> -->