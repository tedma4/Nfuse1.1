class CommentsController < ApplicationController

  def create
    @shout = Shout.find(params[:shout_id])
    @comment = @shout.comments.create(comment_params)
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
      params.require(:comment).permit(:body)
    end
end