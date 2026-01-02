class Event < ApplicationRecord
  validates :location, presence: true
  validates :event_date, presence: true
  belongs_to :creator, class_name: "User"
  has_many :event_attendees, foreign_key: "attended_event_id"
  has_many :attendees, through: :event_attendees, source: :attendee
end
