require 'rails_helper'

RSpec.describe 'campaign_urls/edit', type: :view do
  before(:each) do
    @account = Fabricate(:account)
    @current_account = @account
    @campaign = assign(:campaign, Fabricate(:campaign, account: @account))
    @campaign_url = assign(:campaign_url, Fabricate(:campaign_url, campaign: @campaign))
    @groups = assign(:groups, @account.groups)
  end

  it 'renders the edit campaign_url form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_url_path(@account, @campaign, @campaign_url), 'post' do
      assert_select 'select[name=?]', 'campaign_url[group_id]'

      assert_select 'input[name=?]', 'campaign_url[url]'
    end
  end
end
