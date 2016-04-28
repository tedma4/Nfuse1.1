class Comments::LikeCommentsController < ApplicationController

  respond_to :json, :js, :html

  def create
    unless ActsAsVotable::Vote.find_by(voter_id:   current_user.id,
                                       owner_id:   params[:owner_id],
                                       owner_type: params[:owner_type],
                                       votable_id: params[:id])
      send( params.fetch(:key, :basic).to_sym ) # Object.send
    end
    @comment = {
        id: params[:id],
        like_score: ActsAsVotable::Vote.where(votable_id: params[:id]).size,
        owner_id: params[:owner_id],
        owner_type: params[:owner_type],
        parent: params[:has_parent]
    }
    # TODO Turn off PA when a user likes their own thing
    if current_user.id != @comment[:owner_id].to_i && @comment[:owner_type] != 'Page'
      if @comment[:parent].nil?
        current_user.create_activity(key: 'comment.like', parameters: {id: @comment[:id]},
                                      owner: current_user, recipient: User.find_by_id(@comment[:owner_id])
                                    )# unless options[:owner]['id'] == options[:recipient]['id']
        PublicActivity::Activity.last.update_attributes(trackable_id: @comment[:id], trackable_type: 'Comment')
      else
        current_user.create_activity(key: 'comment.sub_comment_like', parameters: {id: @comment[:id]},
                                     owner: current_user, recipient: User.find_by_id(@comment[:owner_id])
        )# unless options[:owner]['id'] == options[:recipient]['id']
        PublicActivity::Activity.last.update_attributes(trackable_id: @comment[:id], trackable_type: 'Comment')
      end
    end
    respond_to do |format|
      format.js { render file: 'comments/like.js.erb'} #'alert("like")' and return
    end
  end

  def destroy
    @comment = {
        id: params[:id],
        like_score: ActsAsVotable::Vote.where(votable_id: params[:id]).size,
        owner_id: params[:owner_id],
        owner_type: params[:owner_type],
        parent: params[:has_parent]
    }
    @like = ActsAsVotable::Vote.where(voter_id: current_user.id, votable_id: params[:id])
    @like.destroy
    # activity = PublicActivity::Activity.find_by_trackable_id_and_trackable_type(params['id'], 'User')
    # activity.destroy if activity.present?
    respond_to do |format|
      format.js { render file: 'comments/dislike.js.erb'}
    end
  end

  private

  def basic
    ActsAsVotable::Vote.create(vote_params)
  end# Ruby magick

  def vote_params
    {votable_id: params[:id],
     votable_type: 'Comment',
      voter_id: current_user.id,
      owner_id: params[:owner_id],
      owner_type: params[:owner_type]}
  end

end