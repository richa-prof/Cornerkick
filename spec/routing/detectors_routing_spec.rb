require 'rails_helper'

RSpec.describe DetectorsController, type: :routing do

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/accounts/1/detectors').to route_to('detectors#index', account_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/accounts/1/detectors/new').to route_to('detectors#new', account_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/accounts/1/detectors/1').to route_to('detectors#show', account_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accounts/1/detectors/1/edit').to route_to('detectors#edit', account_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/accounts/1/detectors').to route_to('detectors#create', account_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1/detectors/1').to route_to('detectors#update', account_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1/detectors/1').to route_to('detectors#update', account_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1/detectors/1').to route_to('detectors#destroy', account_id: '1', id: '1')
    end
  end
end
