require 'rails_helper'

RSpec.describe 'campaign_targets/new', type: :view do
  before(:each) do
    account = Fabricate(:account)
    @current_account = account
    @campaign = assign(:campaign, Fabricate(:campaign, account: account))
    assign(:campaign_target, CampaignTarget.new(
                               landing_page: 'MyString'
    ))
  end

  it 'renders new campaign_target form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_campaign_targets_path(@campaign.account, @campaign), 'post' do
      assert_select 'input[name=?]', 'campaign_target[landing_page]'
    end
  end
end
