class Comments::LikeCommentsController < ApplicationController

  respond_to :json, :js, :html

  def create
    unless vote_found?(current_user, params)
      send( params.fetch(:key, :basic).to_sym ) # Object.send
    end
    @comment = set_comment(params)
    if not_owner_and_not_page? current_user
      if @comment[:parent].nil?
        create_activity(current_user, 'comment.like')
      else
        create_activity(current_user, 'comment.sub_comment_like')
      end
      update_activity(@comment[:id])
    end

    respond_to do |format|
      format.js { render file: 'comments/like.js.erb'} #'alert("like")' and return
    end
  end

  def destroy
    @like = ActsAsVotable::Vote.where(voter_id: current_user.id, votable_id: params[:id])
    @like.destroy
    # activity = PublicActivity::Activity.find_by_trackable_id_and_trackable_type(params['id'], 'User')
    # activity.destroy if activity.present?
    respond_to do |format|
      format.js { render file: 'comments/dislike.js.erb'}
    end
  end

  private

  def update_activity(comment_id)
    PublicActivity::Activity.last.update_attributes(trackable_id: comment_id, trackable_type: 'Comment')
  end

  def set_comment(params)
    {
      id: params[:id],
      like_score: ActsAsVotable::Vote.where(votable_id: params[:id]).size,
      owner_id: params[:owner_id],
      owner_type: params[:owner_type],
      parent: params[:has_parent]
    }
  end

  def vote_found?(current_user, params)
    ActsAsVotable::Vote.find_by( voter_id:   current_user.id,
                                 owner_id:   params[:owner_id],
                                 owner_type: params[:owner_type],
                                 votable_id: params[:id])
  end

  def not_owner_and_not_page?(user)
    user.id != @comment[:owner_id].to_i && @comment[:owner_type] != 'Page'
  end

  def create_activity(current_user, key)
    current_user.create_activity( key: key,
                                  parameters: {id: @comment[:id]},
                                  owner: current_user,
                                  recipient: User.find_by_id(@comment[:owner_id])
                                  # unless options[:owner]['id'] == options[:recipient]['id']
  end

  def basic
    ActsAsVotable::Vote.create(vote_params)
  end

  def vote_params
    { votable_id: params[:id],
      votable_type: 'Comment',
      voter_id: current_user.id,
      owner_id: params[:owner_id],
      owner_type: params[:owner_type]}
  end

end
