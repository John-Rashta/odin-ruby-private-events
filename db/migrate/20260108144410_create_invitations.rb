class CreateInvitations < ActiveRecord::Migration[8.1]
  def change
    create_table :invitations do |t|
      t.references :invited_user, null: false, foreign_key: { to_table: :users }
      t.references :invitation_event, null: false, foreign_key: { to_table: :events }

      t.timestamps
    end
  end
end
