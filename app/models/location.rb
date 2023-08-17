class Location < ApplicationRecord
  belongs_to :organization
  has_many :event_sessions, dependent: :destroy
end
