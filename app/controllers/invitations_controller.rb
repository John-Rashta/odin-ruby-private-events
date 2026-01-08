class InvitationsController < ApplicationController
  before_action :event_params
  before_action :validate_invitation, only: %i[ create ]
  def create
    @invitation = Invitation.build(invitation_event_id: @filtered_params[:event], invited_user_id: @filtered_params[:user].id)
    if @invitation.save
      flash[:notice] = "Invitation Sent!"
    else
      flash[:alert] = "Failed To Send Invitation!"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @invitation = current_user.invitations.where(invitation_event_id: @filtered_params[:event]).first
    if @invitation.destroy
      flash[:notice] = "Successfully Rejected Invitation!"
    else
      flash[:alert] = "Failed to Rejected Invitation!"
    end
    redirect_back(fallback_location: root_path)
  end

  def event_params
    @filtered_params = params.expect(info: [ :user, :event ])
    @filtered_params[:user] = User.where(email: @filtered_params[:user]).first if @filtered_params.key?(:user)
    @filtered_params
  end

  private

  def validate_invitation
    if !@filtered_params[:user] || current_user.id == @filtered_params[:user].id ||
      EventAttendee.where(attended_event_id: @filtered_params[:event], attendee_id: @filtered_params[:user]).exists?
        redirect_to events_path
    end
  end
end
