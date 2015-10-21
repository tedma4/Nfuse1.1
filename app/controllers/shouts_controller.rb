class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_shout, only: [:show, :edit, :update, :destroy]
  respond_to :json, :js, :html

  def show
    @commentable = set_shout
    @comments = @commentable.comments
    @comment = Comment.new

    respond_to do |format|
       format.html
       format.json { render json: @shout }
    end

  end

  def new
    @shout = Shout.new
  end

  def edit
  end

  def create
    @shout = current_user.shouts.create(shout_params)
    respond_to do |format|
      if @shout.save
        if @shout.is_exclusive == true
          @shout.create_activity(key: 'shout.shout', owner: current_user, user_recipients: @shout.user.followed_users.pluck(:id) )
        end
          format.html { redirect_to feed_user_path(@shout.user)}
          format.json { render json: @shout, status: :created, location: @shout }
      else
          format.html { redirect_to new_shout_path }
          format.json { render json: @shout.errors, status: :unprocessable_entity }
      end
    end
  end

  def preview
    @shout = Shout.new(url: params['url'])
    render :text => @shout.url_html
  end

  def update
    if @shout.update_attributes(shout_params)
      redirect_to @shout
    else
      render :edit
    end
  end

  def destroy
    @shout.destroy
    redirect_to feed_user_path(@shout.user)
  end

  def nfuse_post
    if @nfuse_page == NfusePage.find_by(social_id: params[:id], social_key: params[:key])
      render json: { nfuse_page: @nfuse_page }
    else
      @nfuse_page = NfusePage.build(params)
      render json: { nfuse_page: @nfuse_page }
    end
  end


  def my_nfuses
    @nfuses = current_user.nfuse_post
    @nfuses.each do |b|
      @shouts = Shout.my_nfuses(b.id)
    end
  end

  private
    def set_shout
      @shout = Shout.find(params[:id])
    end

  def shout_params
      params.require(:shout).permit( :user_id, :content, :pic, :snip, :is_video, :link, :is_link, :is_pic, :url, :url_html, :is_full_video, :video, :is_exclusive )
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to feed_user_path(@user) if @shout.nil?
    end

end
