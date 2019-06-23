class Detector < ApplicationRecord
  validates :name, presence: true

  belongs_to :account

  has_many :detector_conditions
  has_many :detector_effects
  has_many :detector_results

  def startup
    detector_conditions.each do |condition|
      condition.startup
    end

    detector_effects.each do |effect|
      effect.startup
    end
  end

  def process_event(event)
    result = DetectorResult.create(detector: self, event: event)

    conditions_met = check_conditions event, result
    apply_effects event, result if conditions_met
    result
  end
  private

  def check_conditions(event, result)
    conditions_met = true
    detector_conditions.each do |condition|
      evaluation = condition.check(event)
      content = "#{condition.summary} -  #{evaluation}."
      note = DetectorResultNote.create(scribe: condition, detector_result: result, content: content)
      result.detector_result_notes << note
      conditions_met = conditions_met && evaluation
    end
    conditions_met
  end

  def apply_effects(event, result)
    detector_effects.each do |effect|
      effect.apply event, result
      note = DetectorResultNote.create(scribe: effect, detector_result: result, content: effect.summary)
      result.detector_result_notes << note
    end
  end
end
