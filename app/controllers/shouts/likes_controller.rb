class Shouts::LikesController < ApplicationController

  # before_action :like_shout_type
  respond_to :json, :js, :html

  def create
    @shout = Shout.find(params[:id])
    unless ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout.id)
      like_shout_type
    end
    render js: 'alert("like")' and return
  end

  def destroy
    if @like = ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout.id)
      @like.destroy
    end
    render js: 'alert("dislike")' and return
  end

  private

  def like_shout_type
    twitter if params[:key] == 'twitter'
    facebook if params[:key] == 'facebook'
    instagram if params[:key] == 'instagram'
  end

  def twitter
    Twitter::Vote.create(votable_id: params[:id], voter_id: current_user.id) 
  end

  def facebook
    Facebook::Vote.create(votable_id: params[:id], voter_id: current_user.id)
  end

  def instagram
    Instagram::Vote.create(votable_id: params[:id], voter_id: current_user.id) 
  end

end
