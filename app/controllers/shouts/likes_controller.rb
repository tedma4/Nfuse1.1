class Shouts::LikesController < ApplicationController

  respond_to :json, :js, :html

  def create
    unless ActsAsVotable::Vote.find_by(voter_id:   current_user.id,
                                       owner_id:   params[:owner_id],
                                       owner_type: params[:owner_type],
                                       votable_id: params[:id])
      send( params.fetch(:key, :basic).to_sym ) # Object.send
    end
    @shout = {
        id: params[:id],
        like_score: ActsAsVotable::Vote.where(votable_id: params[:id]).size,
        owner_id: params[:owner_id],
        owner_type: params[:owner_type],
        provider: params[:key] || 'nfuse'
    }
    # TODO Turn off PA when a user likes their own thing
    if current_user.id != params[:owner_id].to_i && @shout[:owner_type] != 'Page'
    current_user.create_activity(key: 'shout.like',
                                 parameters: {id:       @shout[:id],
                                              provider: @shout[:provider]},
                                 owner: current_user,
                                 recipient: User.find(@shout[:owner_id]))# unless options[:owner]['id'] == options[:recipient]['id']
    end
    respond_to do |format|
      format.js { render file: 'shouts/like.js.erb'} #'alert("like")' and return
    end
  end

  def destroy
    # @shout = {
    #     id: params[:id],
    #     like_score: ActsAsVotable::Vote.where(votable_id: params[:id]).size,
    #     owner_id: params[:owner_id],
    #     provider: params[:key]
    # }
    @like = ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: params[:id])
    @like.destroy
    # activity = PublicActivity::Activity.find_by_trackable_id_and_trackable_type(params['id'], 'User')
    # activity.destroy if activity.present?
    respond_to do |format|
      format.js { render file: 'shouts/dislike.js.erb'} #'alert("like")' and returnR
    end
  end

  private

  def basic
    ActsAsVotable::Vote.create(vote_params)
  end# Ruby magick


  def twitter
    Twitter::Vote.create(vote_params) 
    # Networks::Vote.create(vote_params) 
  end

  def facebook
    Facebook::Vote.create(vote_params)
    # Networks::Vote.create(vote_params) 
  end

  def instagram
    Instagram::Vote.create(vote_params) 
    # Networks::Vote.create(vote_params) 
  end

  def google_oauth2
    Youtube::Vote.create(vote_params)
    # Networks::Vote.create(vote_params) 
  end

  def vimeo
    Vimeo::Vote.create(vote_params) 
    # Networks::Vote.create(vote_params) 
  end

  def pinterest
    Pinterest::Vote.create(vote_params)
  end

  def gplus
    Gplus::Vote.create(vote_params) 
    # Networks::Vote.create(vote_params) 
  end

  def tumblr
    Tumblr::Vote.create(vote_params) 
    # Networks::Vote.create(vote_params) 
  end

  def vote_params
   {votable_id: params[:id],
      voter_id: current_user.id,
      owner_id: params[:owner_id],
      owner_type: params[:owner_type]}
  end

end
# attrs = {id: params[:id], provider: params[:key]}