class Event < ApplicationRecord
  validates :location, presence: true
  validates :event_date, presence: true
  belongs_to :creator, class_name: "User"
  has_many :event_attendees, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :attendee

  scope :past, -> { where("event_date < ?", Time.now) }
  scope :future, -> { where("event_date >= ?", Time.now) }

  enum :visibility, { private_event: 0, public_event: 1 }
end
