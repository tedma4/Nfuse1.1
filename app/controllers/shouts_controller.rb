class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_shout, only: [:show, :edit, :update, :destroy]
  respond_to :json, :js, :html

  def index
    @shouts = Shout.order('created_at DESC')
    #@shouts = Shout.includes(:user, :comments).order('created_at DESC')
  end

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
          format.html { redirect_to feed_user_path(@shout.user)}
          format.json { render json: @shout, status: :created, location: @shout }
      else
          format.html { render action: "new" }
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
    @current_shout = set_shout
    @shout = @current_shout.reshout_post( params[:user_id], params[:owner_id])
    @shouts = Shout.order('created_at DESC')
    
    respond_to do |format|
      if @shout.save
       format.js {render partial: "shouts/nfuse_post"} 
      end
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
      params.require(:shout).permit( :user_id, :content, :pic, :snip, :is_video, :link, :is_link, :is_pic, :url, :url_html, :has_content )
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to feed_user_path(@user) if @shout.nil?
    end

end
