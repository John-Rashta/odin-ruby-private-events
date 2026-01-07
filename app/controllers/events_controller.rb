class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ "index", "show" ]
  before_action :set_event, only: %i[ edit update destroy ]
  before_action :event_params, only: %i[ create update ]
  def index
    @events = Event.all.includes(:attendees, :creator)
  end

  def show
    @event = Event.find(params[:id])
    unless @event.public_event? || user_signed_in? && (current_user.id == @event.creator.id || @event.attendee_ids.include?(current_user.id))
      redirect_to events_path
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(@filtered_params)
     if @event.save
      @event.attendees << current_user
      redirect_to @event
     else
      render :new, status: :unprocessable_entity
     end
  end

  def edit
  end

  def update
    redirect_to events_path unless @event.creator.id == current_user.id
    if @event.update(@filtered_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "Sucessfully deleted Event!"
    else
      flash[:alert] = "Failed to delete Event!"
    end
    redirect_to current_user
  end

  private
  def set_event
    @event = current_user.created_events.find(params[:id])
  end

  def event_params
    @filtered_params = params.expect(event: [ :location, :event_date, :visibility ])
    @filtered_params[:visibility] = @filtered_params[:visibility].to_i if @filtered_params.key?(:visibility)
  end
end
