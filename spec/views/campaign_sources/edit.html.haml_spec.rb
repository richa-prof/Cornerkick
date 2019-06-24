require 'rails_helper'

RSpec.describe 'campaign_sources/edit', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    @campaign_source = assign(:campaign_source, Fabricate(:campaign_source, campaign: @campaign))
  end

  it 'renders the edit campaign_source form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_source_path(@campaign.account, @campaign, @campaign_source), 'post' do
      assert_select 'input[name=?]', 'campaign_source[name]'
    end
  end
end
