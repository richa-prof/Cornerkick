require 'rails_helper'

RSpec.describe CampaignUrlsController, type: :routing do

  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/accounts/1/campaigns/1/campaign_urls/1').to route_to('campaign_urls#show', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accounts/1/campaigns/1/campaign_urls/1/edit').to route_to('campaign_urls#edit', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1/campaigns/1/campaign_urls/1').to route_to('campaign_urls#update', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1/campaigns/1/campaign_urls/1').to route_to('campaign_urls#update', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1/campaigns/1/campaign_urls/1').to route_to('campaign_urls#destroy', account_id: '1', campaign_id: '1', id: '1')
    end
  end
end
