module Effects
  class AssignGroupEffect < DetectorEffect

    def startup
      @group = Group.find settings['group_id']
    end

    def summary
      build_summary "assigns event contact to group #{@group.name}"
    end

    def apply(event)
      event.contact.add_group @group
    end
  end
end