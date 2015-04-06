class TimelineConcatenator

  def merge(twitter_timeline, instagram_timeline, facebook_timeline, nfuse_timeline, vimeo_timeline, youtube_timeline)#, pinterest_timeline, flickr_timeline
    (twitter_timeline + instagram_timeline + facebook_timeline + nfuse_timeline + vimeo_timeline + youtube_timeline).sort_by { |post| post.created_time }.reverse#+ pinterest_timeline + flickr_timeline
  end

end