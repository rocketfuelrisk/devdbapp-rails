class Event < ApplicationRecord
  belongs_to :campaign
  has_many :event_sessions, dependent: :destroy
  has_many :offsite_appointments, dependent: :destroy
  has_many :home_test_kits, dependent: :destroy
end
