class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  #before_filter :find_commentable
  respond_to :js, :json, :html

  def index
    @comments = Comment.all
  end

  def new
    @comment = @commentable.comments.new
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
    @commentable = find_commentable
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
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
      params.require(:comment).permit(:body)
    end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to feed_user_path(@user) if @event.nil?
  end

  #def load_commentable
  #  resource, id = request.path.split('/')[1, 2]
  #  @commentable = resource.singularize.classify.constantize.find(id)
  #end

  def find_commentable
    params.each do |name, value|
        if name =~ /(.+)_id$/
            return $1.classify.constantize.find(value)
        end
    end
    raise ActiveRecord:NoRecord.new("Couldn\'t find it captain!")
  end
end
