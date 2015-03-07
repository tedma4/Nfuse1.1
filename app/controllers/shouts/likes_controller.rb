class Shouts::LikesController < ApplicationController

  # before_action :like_shout_type
  respond_to :json, :js, :html

  def create
    unless ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: params[:id])
      send( params.fetch(:key, :basic).to_sym ) # Object.send
    end
    render js: 'alert("like")' and return
  end

  def destroy
    if @like = ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @shout)
      @like.destroy
    end
    render js: 'alert("dislike")' and return
  end

  private

  def basic
    ActsAsVotable::Vote.create(vote_params)
  end# Ruby magick


  def twitter
    Twitter::Vote.create(vote_params) 
  end

  def facebook
    Facebook::Vote.create(vote_params)
  end

  def instagram
    Instagram::Vote.create(vote_params) 
  end

  def youtube
    Youtube::Vote.create(vote_params)
  end

  def vimeo
    Vimeo::Vote.create(vote_params) 
  end

  def vote_params
   {votable_id: params[:id], voter_id: current_user.id}
  end

end
