class Patient < ApplicationRecord
  enum :gender, { 'm': 'm', 'f': 'f', 'u': 'u' }, scopes: false

  belongs_to :organization
  has_one :eligibility_record, dependent: :nullify
  has_many :result_sets, dependent: :destroy
  has_many :onsite_appointments, dependent: :destroy
  has_many :offsite_appointments, dependent: :destroy
  has_many :home_test_kits, dependent: :destroy
end
