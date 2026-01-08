class Event < ApplicationRecord
  validates :location, presence: true
  validates :event_date, presence: true
  belongs_to :creator, class_name: "User"
  has_many :event_attendees, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :attendee
  has_many :invitations, foreign_key: "invitation_event_id", dependent: :destroy
  has_many :invited_people, through: :invitations, source: :invited_user

  scope :past, -> { where("event_date < ?", Time.now) }
  scope :future, -> { where("event_date >= ?", Time.now) }

  enum :visibility, { private_event: 0, public_event: 1 }
end
