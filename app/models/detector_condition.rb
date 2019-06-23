class DetectorCondition < ApplicationRecord
  belongs_to :detector
  has_many :detector_result_notes, as: :scribe

  def summary
    build_summary 'Base class for conditions'
  end

  def check(event)
    raise 'Subclass of DetectorCondition Required'
  end

  protected
  def build_summary(description)
    "#{self.class.name}: #{description}"
  end
end
