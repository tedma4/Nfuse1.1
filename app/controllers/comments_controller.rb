class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  respond_to :js, :json, :html
  
  def create
    @shout = Shout.find(params[:content][:shout_id])
    @comment = Comment.create(comment_params)
    @comment.user = current_user
    @comment.save
    redirect_to shout_path(@shout)
  end
 
  def destroy
    @shout = Shout.find(params[:shout_id])
    @comment = @shout.comments.find(params[:id])
    @comment.destroy
    redirect_to shout_path(@shout)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:body, :shout_id)
    end
end