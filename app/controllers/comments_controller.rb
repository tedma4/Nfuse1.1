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
      params.require(:comment).permit(:body)
    end
end



class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
  def comment_params
    params.require(:comment).permit(:body)
  end

  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end










class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml

  before_filter :load_commentable

  
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
 
   @comment.save ? (@comment = @commentable.comments.new() and flash[:notice] = "Comment added") :  flash[:error] = "Enter comment to add it"

    render :update do |page|
      page.replace_html  :comments_id,
               :partial=>"#{@commentable.class.to_s.downcase}s/comments",
               :locals=>{:commentable => @commentable, :comment => @comment}
     
    end
   end
  
  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(comment_params)
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @community = @commentable.community
    
    @comment.destroy

    redirect_to([@community,@commentable], :notice => 'Comment was successfully deleted.')
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_commentable
    @commentable = Event.find params[:event_id] if params[:event_id]
    @commentable = Shout.find params[:post_id] if params[:post_id]
  end
end