class Campaign < ApplicationRecord
  belongs_to :organization
  has_many :events, dependent: :destroy
end
