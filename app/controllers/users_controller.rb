class UsersController < ApplicationController
  include UsersHelper
  #This ensures that a user must be logged in to make changes to a profile
  before_action :signed_in_user,
                only: [:explore, :show, :index, :edit, :update, :destroy, :following, :followers]
  #This ensures that a user is the correct user for a particilar profile
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :user_from_params, only: [:show, :destroy, :feed, :explore, :bio, :following, :followers]

  def index
    #user = User.find(params[:id])
    #This shows all the users a user has a conversation with
    @users = User.all_except(current_user)
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    #This creats a new user
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to callback_links_path
    else
      render 'new'
    end
  end

  def settings
    #This allows a user to add a new network 
    @display_networks = false
  end

  def edit
    #This allows a user to edit their information
  end

  def update
    #This updates a user's profile with the information they edited and saves it
    if @user.update_attributes(user_params)
      redirect_to feed_user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    #This allows an admin user to destroy a user
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def indexed
    #This displays all the networks available that a user can allow access for
    @providers = Providers.for(@user)
    if @providers.none?
      @display_welcome = true
      render 'users/settings'
    end
  end

  def feed
    #This controlls a users feed
    feed                = Feed.new(@user)
    @providers          = Providers.for(@user)
    @timeline           = feed.construct(params)
    @unauthed_accounts  = feed.unauthed_accounts
    # since these two are facebook specfic. i would @_fb_REST_OF_NAME
    @poster_recipient_profile_hash = feed.poster_recipient_profile_hash
    @commenter_profile_hash        = feed.commenter_profile_hash

    @load_more_url = feed_content_path(
      twitter_pagination:     feed.twitter_pagination_id,
      facebook_pagination_id: feed.facebook_pagination_id,
      instagram_max_id:       feed.instagram_max_id
    )

    render 'show_feed'
  end

  def explore
    @providers = Providers.for(@user)
    timeline = []
    @users = User.where.not(id: current_user.followed_users && current_user.id)
    @users.each do |user|
      feed=Feed.new(user)
      timeline << feed.construct(params)
    @unauthed_accounts = feed.unauthed_accounts
    @poster_recipient_profile_hash = feed.poster_recipient_profile_hash
    @commenter_profile_hash = feed.commenter_profile_hash
    end
    @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
    render "explore"
  end

  def bio
    render 'show_bio'
  end

  def following
    #This shows all the users a user is following
    @title = "Following"
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    #This shows all the users following the current user
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def user_from_params
    @user = User.find(params[:id])
  end
end
