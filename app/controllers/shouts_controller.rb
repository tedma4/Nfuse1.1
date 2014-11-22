class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :like_shout_type, only: [:like, :dislike]
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


  def create
    @shout = Shout.create(shout_params) do |shout|
      shout.is_video = true if params[:shout][:snip]
    end
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
    @shout = Shout.find(params[:id])
    @shout.destroy
    redirect_to hub_user_path(@user)
  end

  def like
    @shout = Shout.find(params[:id])
    # like_or_dislike(current_user)
    unless ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout.id)
      @shout.like_by current_user
    end
    render js: 'alert("Liked")'
  end

  def dislike
    @shout = Shout.find(params[:id])
    if ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout.id)
      @shout.unliked_by current_user
    end
    render js: 'alert("UnLiked")'
  end

  private

  def like_shout_type

    if params[:key] == 'twitter'
      ActsAsVotable::Vote.create do |vote|
        vote.social_flag = "twitter"
        vote.votable_id = params[:id]
        vote.voter_id = current_user.id
        vote.votable_type = 'Twitter::Vote'
        vote.vote_flag = true
      end
    end

    render js: 'alert("like")' and return
  end

  def shout_params
      params.require(:shout).permit(:content, :pic, :snip, :user_id)
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to feed_user_path(@user) if @shout.nil?
    end
end