class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  respond_to :json, :js, :html

  #def index
  #  @shouts = Shout.all
  #end

  def show
  end

  def new
    @shout = Shout.new
  end

  #def edit
  #end

  #def update
  #  respond_to do |format|
  #    if @shout.update(params[:shout])
  #      format.html { redirect_to @shout, notice: 'Shout was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @shout.errors, status: :unprocessable_entity }
  #    end
  # end
  #end

  #def create
  #  @shout = Shout.new(shout_params)

  #  respond_to do |format|
  #    if @shout.save
  #      format.html { redirect_to @shout, notice: 'Post was successfully created.' }
  #      format.json { render action: 'show', status: :created, location: @shout }
  #    else
  #      format.html { render action: 'new' }
  #      format.json { render json: @shout.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  def create
    @user = User.find(params[:id])
    @shout = current_user.shouts.build(shout_params)
    if params[:content]
      ShoutPost.create(params[:content])
    elsif params[:pic]
      PicPost.create(params[:pic])
    elsif params[:snip]
      SnipPost.create(params[:snip])
    end
    if @shout.save
      flash[:success] = "Shout created!"
      redirect_to feed_user_path(@user)
    else
      @feed_items = []
      render 'new'
    end
  end

  def destroy
    @shout.destroy
    redirect_to hub_user_path(@user)
  end

  #def destroy
  #  @shout.destroy
  #  respond_to do |format|
  #    format.html { redirect_to shouts_url }
  #    format.json { head :no_content }
  #  end
  #end

  private

    def shout_params
      params.require(:shout).permit(:content, :pic, :snip)
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to root_url if @shout.nil?
    end
end