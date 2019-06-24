require 'rails_helper'

RSpec.describe 'campaigns/new', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    assign(:campaign, Campaign.new(
                        name: 'MyString',
                        account: @account,
                        active: false
    ))
  end

  it 'renders new campaign form' do
    render

    assert_select 'form[action=?][method=?]', account_campaigns_path(@account), 'post' do
      assert_select 'input[name=?]', 'campaign[name]'

      assert_select 'input[name=?]', 'campaign[active]'
    end
  end
end
