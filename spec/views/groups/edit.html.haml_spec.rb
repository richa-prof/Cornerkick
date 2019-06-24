require 'rails_helper'

RSpec.describe 'groups/edit', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @group = assign(:group, Fabricate(:group, account: @account))
    @current_account = @account
  end
  before(:each) do
  end

  it 'renders the edit group form' do
    render

    assert_select 'form[action=?][method=?]', account_group_path(@account, @group), 'post' do
      assert_select 'input#group_name[name=?]', 'group[name]'

      assert_select 'input#group_description[name=?]', 'group[description]'
    end
  end
end
