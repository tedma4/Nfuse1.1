class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  respond_to :json, :js, :html

  #def index
  #  @shouts = Shout.all
  #end

  def show
    @comment = Comment.new
    @shout = Shout.find(params[:id])
    @comments = @shout.comments

    respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @post }
    end

  end

  def new
    @shout = Shout.new
  end

  #def edit
  #  @shout = Shout.find(params[:id])
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

  def create
    @shout = Shout.create(shout_params)
    @shout.user = current_user
      
      respond_to do |format|
        if @shout.save
            format.html { redirect_to @shout, notice: 'Post was successfully created.' }
            format.json { render json: @shout, status: :created, location: @shout }
        else
            format.html { render action: "new" }
            format.json { render json: @shout.errors, status: :unprocessable_entity }
        end
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

  def like
    @shout = Shout.find(params[:id])
    if current_user.liked_by? @shout
      @shout.unliked_by current_user
      respond_to do |format|
        format.json { render json:{vote_id: @shout.id, count: @shout.votes.count}}
        format.html {redirect_to @shout}
      end
    else
      @shout.like :voter => current_user, :like => 'like'
      respond_to do |format|
        format.json { render json:{vote_id: @shout.id, count: @shout.votes.count}}
        format.html {redirect_to @shout, notice: "Thank you for voting!"}
      end
    end 
  end

  def dislike
    @shout = Shout.find(params[:id])
    if current_user.disliked_by? @shout
      @shout.undisliked_by current_user
      respond_to do |format|
        format.json { render json:{vote_id: @shout.id, count: @shout.votes.count}}
        format.html {redirect_to @shout}
      end
    else
      @shout.dislike :voter => current_user, :dislike => 'dislike'
      respond_to do |format|
        format.json { render json:{vote_id: @shout.id, count: @shout.votes.count}}
        format.html {redirect_to @shout, notice: "Thank you for voting!"}
      end
    end 
  end

  private

    def shout_params
      params.require(:shout).permit(:content, :pic, :snip, :user_id)
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to feed_user_path(@user) if @shout.nil?
    end
end