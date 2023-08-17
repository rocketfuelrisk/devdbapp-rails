class HomeTestKit < ApplicationRecord
  STATUSES = %w[pending shipped received processing processed error]
  enum :status, STATUSES.zip(STATUSES).to_h

  belongs_to :event
  belongs_to :patient
end
