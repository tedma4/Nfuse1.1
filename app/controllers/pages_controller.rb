class PagesController < ApplicationController
  
  #before_filter :signed_in_user, only: [:home]

  def home
    if signed_in?
      @user = User.find(session[:user_id])
      @providers = Providers.for(@user)
      timeline = []

      current_user.followed_users.each do |user|
        feed=Feed.new(user)
        timeline << feed.construct(params)
        @unauthed_accounts               = feed.unauthed_accounts
        @poster_recipient_profile_hash   = feed.poster_recipient_profile_hash
        @commenter_profile_hash          = feed.commenter_profile_hash
      end

      @timeline=timeline.flatten.sort {|a, b|  b.created_time <=> a.created_time }
    end
      render "home"
  end

  def help; end
  def about; end
  def feedback; end
  def qanda; end
  def terms; end
  def privacy; end

end
