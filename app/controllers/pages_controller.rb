class PagesController < ApplicationController

  def home
    if signed_in?
      @providers = Providers.for(current_user)
      @timeline  = timeline[:timeline].flatten.sort {|a, b|  b.created_time <=> a.created_time }
      # We need to do something with this
      # because if each user's details is needed.
      # only the last user's data is saved to this loop.
      # hence why i put #first at the end of the hash.

      @unauthed_accounts              = timeline[:unauthed_accounts].first
      @poster_recipient_profile_hash  = timeline[:poster_recipient_profile_hash].first
      @commenter_profile_hash         = timeline[:commenter_profile_hash].first
    end
    # render 'home' is implicit.
  end

  private

  def timeline(user=current_user)
    stack = {
      timeline: [],
      unauthed_accounts: [],
      poster_recipient_profile_hash: [],
      commenter_profile_hash: [],
      feed_unauthed_accounts: []
    }
    current_user.followed_users.each do |user|
      feed=Feed.new(user)
      stack[:timeline] << feed.construct(params)
      # this is constantly getting over written for each user.
      stack[:feed_unauthed_accounts] << feed.unauthed_accounts
      stack[:poster_recipient_profile_hash] << feed.poster_recipient_profile_hash
      stack[:commenter_profile_hash] << feed.commenter_profile_hash
    end
    stack
  end

  public

  def help; end
  def about; end
  def feedback; end
  def qanda; end
  def terms; end
  def privacy; end

end
