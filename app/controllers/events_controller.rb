class EventsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :fetch_event,    except: [:new, :create]
  respond_to :json, :js, :html

  def show
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
    if @event.update_attributes(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: "Event was destroyed."
  end

  def like
    # like_or_dislike(current_user)
    unless ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @event.id)
      @event.like_by current_user
    end
    render js: 'alert("Liked")'
  end

  def dislike
    if ActsAsVotable::Vote.find_by(voter_id: current_user.id, votable_id: @event.id)
      @event.unliked_by current_user
    end
    render js: 'alert("UnLiked")'
  end

  private

  def fetch_event
    @event = Event.find(params[:id])
  end
  
  def event_params
      params.require(:event).permit(:name, :description, :date, :time, :city, :user_id)
  end

  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    redirect_to feed_user_path(@user) if @event.nil?
  end
end


