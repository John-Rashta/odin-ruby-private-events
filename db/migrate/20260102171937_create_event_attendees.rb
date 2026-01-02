class CreateEventAttendees < ActiveRecord::Migration[8.1]
  def change
    create_table :event_attendees do |t|
      t.belongs_to :attendee, foreign_key: { to_table: :users }
      t.belongs_to :attended_event, foreign_key: { to_table: :events }
      t.timestamps
    end
  end
end
