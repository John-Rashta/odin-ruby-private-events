class EventAttendeeController < ApplicationController
  before_action :authenticate_user!
  def create
    @attendance = current_user.event_attendees.build(attended_event_id: event_params)
    if @attendance.save
      flash.now[:success] = "Successfully joined Event!"
    else
      flash.now[:error] = "Failed to join Event!"
    end
  end

  def destroy
    @attendance = current_user.event_attendees.where(attended_event_id: event_params).first
    if @attendance.destroy
      flash.now[:success] = "Successfully left Event!"
    else
      flash.now[:error] = "Failed to leave Event!"
    end
  end

  private

  def event_params
    params.expect(:event)
  end
end
