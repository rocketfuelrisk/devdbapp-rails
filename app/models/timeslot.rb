class Timeslot < ApplicationRecord
  belongs_to :event_session
  has_many :onsite_appointments, dependent: :destroy
end
