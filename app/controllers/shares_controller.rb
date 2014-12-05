class SharesController < ApplicationController
	#This pulls the share count from a user's twitter post

  def twitter
    tweet_id = params[:tweet_id]
    Twitter::Timeline.new(@user).retweet_tweet(tweet_id)
    redirect_to root_path
  end

end