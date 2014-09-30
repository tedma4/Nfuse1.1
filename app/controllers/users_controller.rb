class UsersController < ApplicationController
  include UsersHelper
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update, :show]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    #@users = User.paginate(page: params[:page])
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Nfuse!"
      redirect_to feed_user_path(@user)
    else
      render 'new'
    end
  end

  def settings
    @display_networks = false
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to feed_user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def indexed
    @providers = Providers.for(@user)
    if @providers.none?
      @display_welcome = true
      render 'users/settings'
    end
  end

  def feed
    @title = "Feed"
    puts params
    @user = User.find(params[:id])
    feed = Feed.new(@user)
    @providers = Providers.for(@user)
    @timeline = feed.posts(params[:twitter_pagination], params[:facebook_pagination_id], params[:instagram_max_id])
    @unauthed_accounts = feed.unauthed_accounts
    @poster_recipient_profile_hash = feed.poster_recipient_profile_hash
    @commenter_profile_hash = feed.commenter_profile_hash

    @load_more_url = feed_content_path(
      :twitter_pagination => feed.twitter_pagination_id,
      :facebook_pagination_id => feed.facebook_pagination_id,
      :instagram_max_id => feed.instagram_max_id
    )

    render 'show_feed'
  end

  def hub
    @title = "Hub"
    @user = User.find(params[:id])
    @providers = Providers.for(@user)
    @hub_feed = []
    @timeline = current_user.followed_users.each do |f|
      @hub_feed << Feed.new(f).posts(params[:twitter_pagination], params[:facebook_pagination_id], params[:instagram_max_id])
    end
    render "hub"
  end

  def bio
    @title = "Bio"
    @user = User.find(params[:id])
    render 'show_bio'
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

end
