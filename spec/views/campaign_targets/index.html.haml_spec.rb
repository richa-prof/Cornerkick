require 'rails_helper'

RSpec.describe 'campaign_targets/index', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    assign(:campaign_targets, [
             Fabricate(:campaign_target, landing_page: 'Landing Page', campaign: @campaign),
             Fabricate(:campaign_target, landing_page: 'Landing Page', campaign: @campaign)
           ])
  end

  it 'renders a list of campaign_targets' do
    render
    assert_select 'tr>td', text: 'Landing Page'.to_s, count: 2
  end
end
