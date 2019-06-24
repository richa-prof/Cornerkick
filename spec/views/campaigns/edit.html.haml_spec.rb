require 'rails_helper'

RSpec.describe 'campaigns/edit', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    @campaign = assign(:campaign, Fabricate(:campaign, account: @account))
  end

  it 'renders the edit campaign form' do
    render

    assert_select 'form[action=?][method=?]', account_campaign_path(@account, @campaign), 'post' do
      assert_select 'input[name=?]', 'campaign[name]'

      assert_select 'input[name=?]', 'campaign[active]'
    end
  end
end
