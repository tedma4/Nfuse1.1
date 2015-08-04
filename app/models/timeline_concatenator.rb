class TimelineConcatenator

  def self.merge(twitter_timeline, instagram_timeline, facebook_timeline,
  			nfuse_timeline, vimeo_timeline, youtube_timeline, flickr_timeline, 
  			gplus_timeline, tumblr_timeline)#, pinterest_timeline, flickr_timeline, gplus_timeline
    (twitter_timeline + instagram_timeline + facebook_timeline + 
     nfuse_timeline + vimeo_timeline + youtube_timeline + 
     flickr_timeline + gplus_timeline + tumblr_timeline).sort_by { |post| post.created_time }.reverse#+ pinterest_timeline + flickr_timeline + gplus_timeline
  end

  def self.merge2(posts)
    posts.sort_by { |post| post.created_time }.reverse
  end

end