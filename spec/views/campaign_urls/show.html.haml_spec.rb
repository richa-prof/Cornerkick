require 'rails_helper'

RSpec.describe 'campaign_urls/show', type: :view do
  before(:each) do
    @account = Fabricate(:account)
    @current_account = @account
    @campaign = assign(:campaign, Fabricate(:campaign, account: @account))
    @campaign_url = assign(:campaign_url, Fabricate(:campaign_url, campaign: @campaign, url: 'Url'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Url/)
  end
end
