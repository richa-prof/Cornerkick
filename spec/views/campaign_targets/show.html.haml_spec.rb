require 'rails_helper'

RSpec.describe 'campaign_targets/show', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    @campaign_target = assign(:campaign_target, Fabricate(:campaign_target, campaign: @campaign, landing_page: 'Landing Page'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Landing Page/)
  end
end
