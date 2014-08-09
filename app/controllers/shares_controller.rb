class SharesController < ApplicationController

  def twitter
    tweet_id = params[:tweet_id]
    Twitter::Timeline.new(current_user).retweet_tweet(tweet_id)
    redirect_to feed_path
  end

end