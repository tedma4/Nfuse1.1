class ShoutsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :like_shout_type, only: [:like, :dislike]
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
       format.html # show.html.erb
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
    @shout = Shout.create(shout_params) do |shout|
      shout.is_video = true if params[:shout][:snip]
      shout.is_link = true if params[:shout][:link]
    end
    @shout.user = current_user

    respond_to do |format|
      if @shout.save
          format.html { redirect_to @shout, notice: 'Shout was successfully created.' }
          format.json { render json: @shout, status: :created, location: @shout }
      else
          format.html { render action: "new" }
          format.json { render json: @shout.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @shout = Shout.find(params[:id])
    if @shout.update_attributes(shout_params)
      redirect_to @shout, notice: "Shout was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @shout = Shout.find(params[:id])
    @shout.destroy
    redirect_to root_path
  end

  def like
    @shout = Shout.find(params[:id])
    # like_or_dislike(current_user)
    unless ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout.id)
      @shout.like_by current_user
    end
    redirect_to @shout
  end

  def dislike
    @shout = Shout.find(params[:id])
    if ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout.id)
      @shout.dislike_by current_user
    end
    render 'dislike'
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
    elsif
      params[:key] == 'instagram'
      ActsAsVotable::Vote.create do |vote|
        vote.social_flag = "instagram"
        vote.votable_id = params[:id]
        vote.voter_id = current_user.id
        vote.votable_type = 'Instagram::Vote'
        vote.vote_flag = true
      end
    elsif
      params[:key] == 'facebook'
      ActsAsVotable::Vote.create do |vote|
        vote.social_flag = "facebook"
        vote.votable_id = params[:id]
        vote.voter_id = current_user.id
        vote.votable_type = 'Facebook::Vote'
        vote.vote_flag = true
      end
    end

    render js: 'alert("like")' and return
  end

  def shout_params
      params.require(:shout).permit(:content, :pic, :snip, :user_id, :is_video, :link, :is_link )
    end

    def correct_user
      @shout = current_user.shouts.find_by(id: params[:id])
      redirect_to feed_user_path(@user) if @shout.nil?
    end

end
