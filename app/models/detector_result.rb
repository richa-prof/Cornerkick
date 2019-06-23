class DetectorResult < ApplicationRecord
  belongs_to :detector
  belongs_to :event

  has_many :detector_result_notes
end
