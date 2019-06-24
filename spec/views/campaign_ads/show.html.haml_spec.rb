require 'rails_helper'

RSpec.describe 'campaign_ads/show', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    @campaign_ad = assign(:campaign_ad, Fabricate(:campaign_ad, campaign: @campaign, name: 'Name'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
