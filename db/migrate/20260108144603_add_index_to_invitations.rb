class AddIndexToInvitations < ActiveRecord::Migration[8.1]
  def change
     add_index :invitations, [ :invited_user_id, :invitation_event_id ], unique: true
  end
end
