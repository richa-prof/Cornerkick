require 'rails_helper'

RSpec.describe 'campaign_ads/index', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    assign(:campaign_ads, [
             Fabricate(:campaign_ad, name: 'Name', campaign: @campaign),
             Fabricate(:campaign_ad, name: 'Name', campaign: @campaign)
           ])
  end

  it 'renders a list of campaign_ads' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
  end
end
