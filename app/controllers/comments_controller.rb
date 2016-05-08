# class CommentsController < ApplicationController
#   before_action :signed_in_user, only: [:create, :destroy]
#   # before_action :correct_user,   only: :destroy
#   before_filter :get_parent
#   #before_filter :find_commentable
#   respond_to :js, :json, :html

#   def index
#     @comments = @parent.comments.includes(:comments).all
#   end

#   def new
#     # if find_commentable.is_a? Shout
#     #   @comment = @commentable.comments.new
#     # else
#       @comment = @parent.comments.build
#     # end
#   end

#   def show
#     @comment = Comment.includes(:comments).find(params[:id])

#     respond_to do |format|
#       format.html # show.html.erb
#       format.json  { render :json => @comment }
#     end
#   end

#   def edit
#     @comment = Comment.find(params[:id])
#   end

#   def create
#     # @commentable = find_commentable
#     #
#     # if @commentable.is_a? Shout
#     #   @comment = @commentable.comments.new(comment_params)
#     #   @comment.update_attribute(:user_id, current_user.id)
#     #   @comments = Comment.where(commentable_type: @commentable.class.to_s, commentable_id: @commentable.id)
#     # elsif @commentable.is_a?(Page || Comment)
#     @comment = @parent.comments.build(comment_params)
#     # else
#     #   @comment = @commentable.build(comment_params.merge(@commentable.extras))
#     #   @comment.update_attribute(:user_id, current_user.id)
#     #
#     #   @comments = Comment.where(commentable_type: @commentable.type, commentable_id: @commentable.id)
#     # end
#     if @comment.save
#       redirect_to @comment.page
#     else
#       render :new
#     end
#   end

#   def update
#     @comment = Comment.find(params[:id])

#     respond_to do |format|
#       if @comment.update_attributes(comment_params)
#         format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
#         format.json  { head :ok }
#       else
#         format.html { render :action => "edit" }
#         format.json  { render :json => @comment.errors, :status => :unprocessable_entity }
#       end
#     end
#   end

#   def destroy
#     @comment = Comment.find(params[:id])
#     @comment.destroy
#     redirect_to @commentable, :notice => 'Comment was successfully deleted.'
#   end
 
#   private

#   def comment_params
#     params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id, :page_id, :comment_id )
#   end

#   def get_parent
#     @parent = Page.find_by_id(params[:page_id]) if params[:page_id]
#     @parent = Comment.find_by_id(params[:comment_id]) if params[:comment_id]

#     redirect_to root_path unless defined?(@parent)
#   end

#   # def correct_user
#   #   @event = current_user.events.find_by(id: params[:id])
#   #   redirect_to feed_user_path(@user) if @event.nil?
#   # end

#   # def find_commentable
#   #   params.each do |name, value|
#   #     # params[:shout_id] = 1
#   #     if name =~ /(.+)_id$/
#   #         _rs = $1.split('_')
#   #         return $1.classify.constantize.find(value) if (_rs.length == 1)
#   #         return Commented.set(_rs[0..1].map(&:capitalize).join('::').classify.constantize, value)
#   #         # @commenentable = Shout.find(1)  
#   #     end #|| raise ActiveRecord:NoRecord.new("Couldn\'t find it captain!")
#   #   end
#   # end
# end



class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create]
  # before_action :correct_user,   only: :destroy
  # before_filter :get_parent
  before_filter :find_commentable
  after_filter :get_tags, only: :create
  respond_to :js, :json, :html

  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new( parent_id: @parent_id,
                            commentable_id: @commentable.id,
                            commentable_type: @commentable.class.to_s, 
                            user_id: params[:user_id])
  end
  
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        # if @commentable.is_a?(Page)
        #   OurAwesomeMailer.forum_post(@comment.user, @comment, @commentable).deliver
        # else
        #   OurAwesomeMailer.forum_post(@comment.user, @comment).deliver
        # end
        # flash[:notice] = "Successfully created comment."
        format.html {redirect_to @commentable}
        format.js
      else
        flash[:error] = "Error adding comment."
        format.html {redirect_to @commentable}
        format.js
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end
 
  private

  def get_tags
    # @comment = Comment.find(params[:id])
    hashtags = @comment.body.scan(/\B#\w+/).map { |s| s.gsub('#', '')}
    users = @comment.body.scan(/\B@\w+/).map { |s| s.gsub('@', '')}
    unless hashtags.empty?
      @comment.update_attributes(hashtag: hashtags.join(', '))
    end

    unless users.empty?
      @comment.update_attributes(tagged_user: users.join(', '))
      @comment.create_activity(key: 'comment.tagged',
                               owner: current_user, 
                               user_recipients: User.where(user_name: users).pluck(:id).join(', ')
                              ) if User.where(user_name: users).any?
    end

    @comment.create_activity(key: 'comment.new_comment',
                             owner: current_user,
                             user_recipients: @comment.parent.user_id
                            )
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id, :page_id, :comment_id, :parent_id, :url, :url_html, :image_upload, :topic )
  end

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end