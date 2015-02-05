class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  respond_to :json, :js, :html

  def index
    @shouts = Shout.order('created_at DESC')
  end

  def show
    @shout = Shout.find(params[:id])
    @commentable = @shout
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
    @shout = Shout.find(params[:id])
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
    @shout = Shout.find(params[:id])
    if @shout.update_attributes(shout_params)
      redirect_to @shout
    else
      render :edit
    end
  end

  def destroy
    @shout = Shout.find(params[:id])
    @shout.destroy
    redirect_to feed_user_path(@shout.user)
  end

  private

  def shout_params
      params.require(:shout).permit( :user_id, :content, :pic, :snip, :is_video, :link, :is_link, :is_pic, :url, :url_html )
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to feed_user_path(@user) if @shout.nil?
    end

end
