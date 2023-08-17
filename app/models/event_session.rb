class EventSession < ApplicationRecord
  belongs_to :event
  belongs_to :location
  has_many :timeslots, dependent: :destroy
end
