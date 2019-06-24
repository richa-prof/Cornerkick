require 'rails_helper'

RSpec.describe 'campaign_ads/edit', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    @campaign_ad = assign(:campaign_ad, Fabricate(:campaign_ad, campaign: @campaign))
  end

  it 'renders the edit campaign_ad form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_ad_path(@campaign.account, @campaign, @campaign_ad), 'post' do
      assert_select 'input[name=?]', 'campaign_ad[name]'
    end
  end
end
