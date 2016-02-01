class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  # before_action :correct_user,   only: :destroy
  before_filter :get_parent
  #before_filter :find_commentable
  respond_to :js, :json, :html

  def index
    @comments = @parent.comments.all
  end

  def new
    # if find_commentable.is_a? Shout
    #   @comment = @commentable.comments.new
    # else
      @comment = @parent.comments.build
    # end
  end

  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @comment }
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    # @commentable = find_commentable
    #
    # if @commentable.is_a? Shout
    #   @comment = @commentable.comments.new(comment_params)
    #   @comment.update_attribute(:user_id, current_user.id)
    #   @comments = Comment.where(commentable_type: @commentable.class.to_s, commentable_id: @commentable.id)
    # elsif @commentable.is_a?(Page || Comment)
    @comment = @parent.comments.build(comment_params)
    # else
    #   @comment = @commentable.build(comment_params.merge(@commentable.extras))
    #   @comment.update_attribute(:user_id, current_user.id)
    #
    #   @comments = Comment.where(commentable_type: @commentable.type, commentable_id: @commentable.id)
    # end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @commentable, :notice => 'Comment was successfully deleted.'
  end
 
  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id, :page_id, :comment_id )
  end

  def get_parent
    @parent = Page.find_by_id(params[:page_id]) if params[:page_id]
    @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]

    redirect_to root_path unless defined?(@parent)
  end

  # def correct_user
  #   @event = current_user.events.find_by(id: params[:id])
  #   redirect_to feed_user_path(@user) if @event.nil?
  # end

  # def find_commentable
  #   params.each do |name, value|
  #     # params[:shout_id] = 1
  #     if name =~ /(.+)_id$/
  #         _rs = $1.split('_')
  #         return $1.classify.constantize.find(value) if (_rs.length == 1)
  #         return Commented.set(_rs[0..1].map(&:capitalize).join('::').classify.constantize, value)
  #         # @commenentable = Shout.find(1)
  #     end #|| raise ActiveRecord:NoRecord.new("Couldn\'t find it captain!")
  #   end
  # end
end
