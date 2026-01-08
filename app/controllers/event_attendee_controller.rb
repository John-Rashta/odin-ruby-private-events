class EventAttendeeController < ApplicationController
  before_action :authenticate_user!
  def create
    @event = event_params
    @attendance = current_user.event_attendees.build(attended_event_id: @event)
    if @attendance.save
      if @invitation = current_user.invitations.where(invitation_event_id: @event).first
        @invitation.destroy
      end
      flash[:notice] = "Successfully joined Event!"
    else
      flash[:alert] = "Failed to join Event!"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @attendance = current_user.event_attendees.where(attended_event_id: event_params).first
    if @attendance.destroy
      flash[:notice] = "Successfully left Event!"
    else
      flash[:alert] = "Failed to leave Event!"
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def event_params
    params.expect(:event)
  end
end
