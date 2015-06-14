class UsersController < ApplicationController
  include UsersHelper
  #This ensures that a user must be logged in to make changes to a profile
  before_action :signed_in_user,
                only: [:explore, :show, :index, :edit, :update, :destroy, :following, :followers, :nfuse_page, :feed]
  #This ensures that a user is the correct user for a particilar profile
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :user_from_params, only: [:show, :destroy, :feed, :explore, :following, :followers, :nfuse_page, :nfuse_only, :twitter_only, :instagram_only, :facebook_only, :youtube_only]

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
        instagram_max_id:       feed.instagram_max_id,
        nfuse_post_last_id:     feed.nfuse_pagination_id,
        youtube_pagination:     feed.youtube_pagination_id,
        id: @user.id)
  end

  def explore
    @providers = Providers.for(@user)
    timeline = []
    @users = User.where.not(id: current_user.followed_users && current_user.id)
    @users.each do |user|
      feed=Feed.new(user)
      timeline << feed.construct(params)

    @unauthed_accounts              = feed.unauthed_accounts
    @poster_recipient_profile_hash  = feed.poster_recipient_profile_hash
    @commenter_profile_hash         = feed.commenter_profile_hash
    end

    @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
    render "explore"
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

  def nfuse_only
    #These are concept pages for toggling network's posts i.e. viewing only the posts you want to see
    #fron certain networks. Idk the js/ruby needed to do this so these will have to do for now
    only_pages
  end

  def twitter_only
    #These are concept pages for toggling network's posts i.e. viewing only the posts you want to see
    #fron certain networks. Idk the js/ruby needed to do this so these will have to do for now
    only_pages
  end

  def instagram_only
    #These are concept pages for toggling network's posts i.e. viewing only the posts you want to see
    #fron certain networks. Idk the js/ruby needed to do this so these will have to do for now
    only_pages
  end

  def facebook_only
    #These are concept pages for toggling network's posts i.e. viewing only the posts you want to see
    #fron certain networks. Idk the js/ruby needed to do this so these will have to do for now
    only_pages
  end

  def youtube_only
    #These are concept pages for toggling network's posts i.e. viewing only the posts you want to see
    #fron certain networks. Idk the js/ruby needed to do this so these will have to do for now
    only_pages
  end

  def only_pages
    @providers = Providers.for(current_user)
    @timeline  = timeline[:timeline].flatten.sort {|a, b|  b.created_time <=> a.created_time }
    @unauthed_accounts              = timeline[:unauthed_accounts].first
    @poster_recipient_profile_hash  = timeline[:poster_recipient_profile_hash].first
    @commenter_profile_hash         = timeline[:commenter_profile_hash].first
  end

  def explore_nfuse_only
    explore_only_pages
    render "explore_nfuse_only"
  end

  def explore_twitter_only
    explore_only_pages
    render "explore_twitter_only"
  end

  def explore_instagram_only
    explore_only_pages
    render "explore_instagram_only"
  end

  def explore_facebook_only
    explore_only_pages
    render "explore_facebook_only"
  end

  def explore_youtube_only
    explore_only_pages
    render "explore_youtube_only"
  end

  def explore_only_pages
    @providers = Providers.for(@user)
    timeline = []
    @users = User.where.not(id: current_user.followed_users && current_user.id)
    @users.each do |user|
      feed=Feed.new(user)
      timeline << feed.construct(params)

    @unauthed_accounts              = feed.unauthed_accounts
    @poster_recipient_profile_hash  = feed.poster_recipient_profile_hash
    @commenter_profile_hash         = feed.commenter_profile_hash
    end

    @timeline=timeline.flatten.sort { |a, b| b.created_time <=> a.created_time}
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
end
