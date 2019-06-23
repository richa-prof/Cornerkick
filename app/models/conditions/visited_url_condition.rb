module Conditions
  class VisitedUrlCondition < DetectorCondition

    def summary
      build_summary "Identifies events matching #{settings['url']}"
    end

    def check(event)
      url = settings['url']
      desired_params = settings['params']

      uri = URI(event.url)
      target_uri = URI(url)
      params = Rack::Utils.parse_nested_query(uri.query)

      return false unless target_uri.host.eql?(uri.host) && target_uri.path.eql?(uri.path)
      desired_params.each do |param, value|
        return false unless params[param.to_s].eql? value
      end

      true
    end
  end
end