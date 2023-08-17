class OnsiteAppointment < ApplicationRecord
  belongs_to :timeslot
  belongs_to :patient
end
