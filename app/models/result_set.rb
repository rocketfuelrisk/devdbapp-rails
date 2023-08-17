class ResultSet < ApplicationRecord
  belongs_to :patient
  has_many :results, dependent: :destroy
end
