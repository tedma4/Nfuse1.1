class PagesController < ApplicationController
  #this is the static pages used in Nfuse

  def home
    @user = User.find(session[:user_id])
    @providers = Providers.for(@user)

    timeline = []
    current_user.followed_users.each do |user|
      timeline << fetch_feed( Feed.new(user), user )
    end

    @timeline=timeline.flatten.sort {|a, b|  b.created_time <=> a.created_time }
    render "home"
  end

  def help
  end

  def about
  end

  def feedback
  end

  def qanda
  end

  def terms
  end

  def privacy
  end

  def fetch_feed(feed, user=current_user)
    feed.posts(params[:twitter_pagination], params[:facebook_pagination_id], params[:instagram_max_id], user.id)
  end
end
