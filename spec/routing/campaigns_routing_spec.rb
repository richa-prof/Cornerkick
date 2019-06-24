require 'rails_helper'

RSpec.describe CampaignsController, type: :routing do

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/accounts/1/campaigns').to route_to('campaigns#index', account_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/accounts/1/campaigns/new').to route_to('campaigns#new', account_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/accounts/1/campaigns/1').to route_to('campaigns#show', account_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accounts/1/campaigns/1/edit').to route_to('campaigns#edit', account_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/accounts/1/campaigns').to route_to('campaigns#create', account_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1/campaigns/1').to route_to('campaigns#update', account_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1/campaigns/1').to route_to('campaigns#update', account_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1/campaigns/1').to route_to('campaigns#destroy', account_id: '1', id: '1')
    end

    it 'routes to #generate_urls' do
      expect(post: '/accounts/1/campaigns/1/generate_urls').to route_to('campaigns#generate_urls', account_id: '1', id: '1')
    end
  end
end
