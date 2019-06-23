module Effects
  class NoOpEffect < DetectorEffect

    def summary
      build_summary 'No effect'
    end

    def apply(event, result)
    end
  end
end