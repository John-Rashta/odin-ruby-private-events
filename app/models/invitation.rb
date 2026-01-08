class Invitation < ApplicationRecord
  belongs_to :invitation_event, class_name: "Event"
  belongs_to :invited_user, class_name: "User"
  validates_uniqueness_of :invited_user_id, scope: :invitation_event_id
end
