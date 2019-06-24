require 'rails_helper'

RSpec.describe 'campaign_sources/new', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    assign(:campaign_source, CampaignSource.new(
                               name: 'Name'
    ))
  end

  it 'renders new campaign_source form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_sources_path(@campaign.account, @campaign), 'post' do
      assert_select 'input[name=?]', 'campaign_source[name]'
    end
  end
end
