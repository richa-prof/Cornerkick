require 'rails_helper'

RSpec.describe GroupsController, type: :routing do

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/accounts/1/groups').to route_to('groups#index', account_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/accounts/1/groups/new').to route_to('groups#new', account_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/accounts/1/groups/1').to route_to('groups#show', account_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accounts/1/groups/1/edit').to route_to('groups#edit', account_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/accounts/1/groups').to route_to('groups#create', account_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1/groups/1').to route_to('groups#update', account_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1/groups/1').to route_to('groups#update', account_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1/groups/1').to route_to('groups#destroy', account_id: '1', id: '1')
    end
  end
end
