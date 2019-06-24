require 'rails_helper'

RSpec.describe CampaignAdsController, type: :routing do

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/accounts/1/campaigns/1/campaign_ads').to route_to('campaign_ads#index', account_id: '1', campaign_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/accounts/1/campaigns/1/campaign_ads/new').to route_to('campaign_ads#new', account_id: '1', campaign_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/accounts/1/campaigns/1/campaign_ads/1').to route_to('campaign_ads#show', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accounts/1/campaigns/1/campaign_ads/1/edit').to route_to('campaign_ads#edit', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/accounts/1/campaigns/1/campaign_ads').to route_to('campaign_ads#create', account_id: '1', campaign_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1/campaigns/1/campaign_ads/1').to route_to('campaign_ads#update', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1/campaigns/1/campaign_ads/1').to route_to('campaign_ads#update', account_id: '1', campaign_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1/campaigns/1/campaign_ads/1').to route_to('campaign_ads#destroy', account_id: '1', campaign_id: '1', id: '1')
    end
  end
end
