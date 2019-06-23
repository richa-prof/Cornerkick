class DetectorResultNote < ApplicationRecord
  belongs_to :detector_result
  belongs_to :scribe, polymorphic: true
end
