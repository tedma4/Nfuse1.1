class UsersController < ApplicationController
  include UsersHelper
  rescue_from ActionController::ParameterMissing, with: :update_error
  #This ensures that a user must be logged in to make changes to a profile
  before_action :signed_in_user,
                only: [:explore, :explore_users, :show, :index, :edit, :update, :destroy, :following, :followers, :nfuse_page, :feed]
  #This ensures that a user is the correct user for a particilar profile
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :user_from_params, only: [:show, :destroy, :feed, :explore, :explore_users, :following, :followers, :nfuse_page ]

  def index
    #user = User.find(params[:id])
    #This shows all the users a user has a conversation with
    #TODO what is the @users query for. What is the purpose of loading EVERY user but current
    @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
    @conversations = Conversation.involving(current_user).order("created_at DESC")
  end

  def show; end

  def new
    @user = User.new
  end

  def destroyuser
     PublicActivity::Activity.destroy_all
     redirect_to root_path
  end

  def remove_token
    current_user.tokens.find_by(provider: params['provider']).destroy
    redirect_to edit_user_path(current_user)
  end

  def destroytoken
     Token.last.destroy
     redirect_to root_path
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
    @user.update_attributes(user_params)
    if @user.errors.any?
      render 'edit'
    else
      redirect_to feed_user_path(@user)
    end
  end

  def destroy
    #This allows an admin user to destroy a user
    #TODO shouldnt a user be able to delete themself? Why can only admins delete?
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  #TODO Is this deprecated?  It does not correspond to any set route
  def indexed
    #This displays all the networks available that a user can allow access for
    @providers = Providers.for(@user)
    if @providers.none?
      @display_welcome = true
      render 'users/settings'
    end
  end

  def feed_content
    @user = User.find(params[:id])
    feed_builder
    render 'feed_content', layout: false
  end

  def feed
    feed_builder
    render 'show_feed'

  end

  def feed_builder
    @providers          = Providers.for(current_user)
    feed                = Networks::Timeline.new(@user)
    @timeline           = feed.construct(params).sort { |a, b| b.created_time <=> a.created_time }
    @unauthed_accounts  = feed.unauthed_accounts

    # @load_more_url = feed_content_path(
    #     twitter_pagination:     feed.twitter_pagination_id,
    #     facebook_pagination:    feed.facebook_pagination_id,
    #     instagram_max_id:       feed.instagram_max_id,
    #     nfuse_post_last_id:     feed.nfuse_pagination_id,
    #     youtube_pagination:     feed.youtube_pagination_id,
    #     gplus_pagination:       feed.gplus_pagination_id,
    #     tumblr_pagination:      feed.tumblr_pagination_id,
    #     vimeo_pagination:       feed.vimeo_pagination_id,
    #     flickr_pagination:      feed.flickr_pagination_id,
    #     id: @user.id)
  end

  def explore
  end

  def explore_users
    @providers = Providers.for(@user)
    timeline = []
    ids =  current_user.followed_users.collect(&:id)
    ids << current_user.id
    unless ids.empty?
      @users = User.where.not(id: ids)
      @users.each do |user|
        feed=Networks::Timeline.new(user)
        timeline << feed.construct(params)
        @unauthed_accounts = feed.unauthed_accounts
      end
    end
    @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
    render "explore_users"
  end

  def bio
    render 'show_bio'
  end

  def following
    @title = "Following"
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def user_from_params
    @user = User.find_by_user_name(params[:id])
  end

  def nfuse_page
    @nfuse_pages = NfusePage.where(user_id: @user.id).order('created_at DESC')
  end

  private
  def update_error  
    redirect_to feed_user_path(@user)
  end
end
