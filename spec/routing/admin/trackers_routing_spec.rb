require 'rails_helper'

RSpec.describe Admin::TrackersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/trackers').to route_to('admin/trackers#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/trackers/new').to route_to('admin/trackers#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/trackers/1').to route_to('admin/trackers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/trackers/1/edit').to route_to('admin/trackers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/trackers').to route_to('admin/trackers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/trackers/1').to route_to('admin/trackers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/trackers/1').to route_to('admin/trackers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/trackers/1').to route_to('admin/trackers#destroy', id: '1')
    end
  end
end
