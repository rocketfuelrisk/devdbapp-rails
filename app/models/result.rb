class Result < ApplicationRecord
  belongs_to :result_set
  belongs_to :measurement
end
