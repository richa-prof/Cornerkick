require 'rails_helper'

RSpec.describe 'campaign_targets/edit', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    @campaign_target = assign(:campaign_target, Fabricate(:campaign_target, campaign: @campaign))
  end

  it 'renders the edit campaign_target form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_target_path(@campaign_target.account, @campaign_target.campaign, @campaign_target), 'post' do
      assert_select 'input[name=?]', 'campaign_target[landing_page]'
    end
  end
end
