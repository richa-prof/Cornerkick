class DetectorEffect < ApplicationRecord
  belongs_to :detector
  has_many :detector_result_notes, as: :scribe

  def startup

  end

  def summary
    build_summary 'Base class for effects'
  end

  def apply(event)
    raise 'Subclass of DetectorEffect Required'
  end

  protected
  def build_summary(description)
    "#{self.class.name}: #{description}"
  end
end
