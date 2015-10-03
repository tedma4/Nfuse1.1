class Shouts::LikesController < ApplicationController

  respond_to :json, :js, :html

  def create
    unless ActsAsVotable::Vote.find_by(voter_id:   current_user.id,
                                       owner_id:   params[:owner_id], 
                                       votable_id: params[:id])
      send( params.fetch(:key, :basic).to_sym ) # Object.send
    end
    @shout = {
        id: params[:id],
        like_score: ActsAsVotable::Vote.where(votable_id: params[:id]).count,
        owner_id: params[:owner_id],
        provider: params[:key]
    }
    current_user.create_activity(key: 'shout.like',
                                 parameters: {id:       @shout[:id],
                                              provider: @shout[:provider]},
                                 owner: current_user,
                                 recipient: User.find_by(@shout[owner_id: params[:owner_id]]))
    respond_to do |format|
      #if @shout.save
        #@shout.create_activity(:like, owner: current_user, recipient: ActsAsVotable::Vote.find_by(owner_id: params[:owner_id]))
        format.js { render file: 'shouts/like.js.erb'} #'alert("like")' and return
      #end
    end
  end

  def destroy
    if @like == ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: params[:id])
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

  # def pinterest
  #   Pinterest::Vote.create(vote_params)
  # end

  def flickr
    Flickr::Vote.create(vote_params) 
  end

  def gplus
    Gplus::Vote.create(vote_params) 
  end

  def tumblr
    Tumblr::Vote.create(vote_params) 
  end

  def vote_params
   {votable_id: params[:id],
      voter_id: current_user.id, 
      owner_id: params[:owner_id]}
  end

end
