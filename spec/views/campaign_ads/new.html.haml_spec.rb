require 'rails_helper'

RSpec.describe 'campaign_ads/new', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    assign(:campaign_ad, CampaignAd.new(
                           name: 'Name'
    ))
  end

  it 'renders new campaign_ad form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_ads_path(@campaign.account, @campaign), 'post' do
      assert_select 'input[name=?]', 'campaign_ad[name]'
    end
  end
end
