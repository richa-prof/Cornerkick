module Conditions
  class AlwaysTrueCondition < DetectorCondition

    def summary
      build_summary 'Always Evaluates True'
    end

    def check(event)
      true
    end
  end
end