class EligibilityRecord < ApplicationRecord
  enum :gender, { 'm': 0, 'f': 1, 'u': 2 }, scopes: false

  belongs_to :organization
  belongs_to :patient, optional: true
end
