class EventAttendee < ApplicationRecord
  belongs_to :attended_event, class_name: "Event"
  belongs_to :attendee, class_name: "User"
  validates_uniqueness_of :attendee_id, scope: :attended_event_id
end
