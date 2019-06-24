require 'rails_helper'

RSpec.describe 'campaign_sources/show', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    @campaign_source = assign(:campaign_source, Fabricate(:campaign_source, campaign: @campaign, name: 'Name'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
