class TimelineConcatenator

  def merge(twitter_timeline, instagram_timeline, nfuse_timeline, vimeo_timeline, youtube_timeline, gplus_timeline, tumblr_timeline, facebook_timeline)#, pinterest_timeline
    (twitter_timeline + instagram_timeline + nfuse_timeline + vimeo_timeline + youtube_timeline + gplus_timeline + tumblr_timeline + facebook_timeline).sort_by { |post| post.created_time }.reverse#+ pinterest_timeline
  end

end