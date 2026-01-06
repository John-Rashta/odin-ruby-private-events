class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ "index" ]
  def index
    @events = Event.all.includes(:attendees, :creator)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)
     if @event.save
      @event.attendees << current_user
      redirect_to @event
     else
      render :new, status: :unprocessable_entity
     end
  end

  def destroy
    @event = current_user.created_events.find(params[:id])
    if @event.destroy
      redirect_to current_user
    else
      flash.now[:error] = "Failed to delete Event!"
    end
  end

  private

  def event_params
    params.expect(event: [ :location, :event_date ])
  end
end
