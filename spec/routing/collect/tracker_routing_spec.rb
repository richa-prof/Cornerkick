require 'rails_helper'

RSpec.describe Collect::TrackerController, type: :routing do

  describe 'routing' do
    it 'routes to #pixel' do
      expect(get: '/collect/CK-339393').to route_to('collect/tracker#pixel', identifier: 'CK-339393')
    end

    it 'routes to #submission' do
      expect(post: '/collect/CK-339393').to route_to('collect/tracker#submission', identifier: 'CK-339393')
    end
  end
end
