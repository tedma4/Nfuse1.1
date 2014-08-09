class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
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
      sign_in @user
      flash[:success] = "Welcome to Nfuse!"
      redirect_to feed_user_path(@user)
    else
      render 'new'
    end
  end

 def settings
    @display_welcome = false
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

  def feed
    @title = "Feed"
    @user = User.find(params[:id])
    render 'show_feed'
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

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, 
        :intro,
        :height,
        :relationship_status,
        :interested_in,
        :looking_for,
        :gender,
        :birthdate, 
        :religious_views,
        :hometown,
        :political_views,
        :occupation,
        :skills,
        :phone_number,
        :fav_movie,
        :fav_book,
        :fav_music,
        :fav_food,
        :fav_quote,
        :movie_or_play,
        :wishes,
        :tv_or_book,
        :invisible_or_read_minds,
        :lottery_or_perfect_job,
        :visit_any_country,
        :fail_or_never_try,
        :meet_in_history,
        :nobody_judges_you,
        :change_about_the_world
        )
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  end


#    add_column :users, :intro, :text
#    add_column :users, :gender, :integer, default: 1
#    add_column :users, :birthdate, :datetime
#    add_column :users, :height, :integer
#    add_column :users, :relationship_status, :integer, default: 1
#    add_column :users, :interested_in, :integer, default: 1
#    add_column :users, :looking_for, :integer, default: 1
#    add_column :users, :religious_views, :string
#    add_column :users, :hometown, :string
#    add_column :users, :political_views, :string
#    add_column :users, :occupation, :string
#    add_column :users, :skills, :string
#    add_column :users, :phone_number, :string
#    add_column :users, :fav_movie, :string
#    add_column :users, :fav_book, :string
#    add_column :users, :fav_music, :string
#    add_column :users, :fav_food, :string
#    add_column :users, :fav_quote, :string
#    add_column :users, :movie_or_play, :string
#    add_column :users, :wishes, :string
#    add_column :users, :tv_or_book, :string
#    add_column :users, :invisible_or_read_minds, :string
#    add_column :users, :lottery_or_perfect_job, :string
#    add_column :users, :visit_any_country, :string
#    add_column :users, :fail_or_never_try, :string
#    add_column :users, :meet_in_history, :string
#    add_column :users, :nobody_judges_you, :string
#    add_column :users, :change_about_the_world, :string