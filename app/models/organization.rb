class Organization < ApplicationRecord
  has_many :patients, dependent: :destroy
  has_many :eligibility_records, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :events, through: :campaigns
  has_many :event_sessions, through: :events
  has_many :timeslots, through: :event_sessions
end
