class RelationshipsController < ApplicationController
  #This ensures that a user must be logged in to follow/unfollow a user
  before_action :signed_in_user

  def create
    #This allows a user to follow another user
    #@page = Page.find(params[:relationship][:followed_id])
    @user = @_env['HTTP_REFERER'].include?('feed' && 'users') ?
        User.find(params[:relationship][:followed_id]) :
        Page.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    #@user ? current_user.follow!(@user) : current_user.follow!(@page)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    #This allows a user to unfollow a user they are following
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end