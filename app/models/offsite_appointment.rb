class OffsiteAppointment < ApplicationRecord
  belongs_to :event
  belongs_to :patient
end
