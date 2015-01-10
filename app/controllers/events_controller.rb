class EventsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  respond_to :json, :js, :html

  #def index
  #  @event = Event.all
  #end

  def show
    @event = Event.find(params[:id])
    @commentable = @event
    @comments = @commentable.comments
    @comment = Comment.new

    respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @event }
    end
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @Event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url, notice: "Event was destroyed."
  end

  def like
    @event = Event.find(params[:id])
    # like_or_dislike(current_user)
    unless ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @event.id)
      @event.like_by current_user
    end
    render js: 'alert("Liked")'
  end

  def dislike
    @event = Event.find(params[:id])
    if ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @event.id)
      @event.unliked_by current_user
    end
    render js: 'alert("UnLiked")'
  end

  private
  
  def event_params
      params.require(:event).permit(:name, :description, :date, :time, :city, :user_id)
  end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to feed_user_path(@user) if @event.nil?
  end
end


