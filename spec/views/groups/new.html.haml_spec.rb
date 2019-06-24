require 'rails_helper'

RSpec.describe 'groups/new', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    @group = assign(:group, Group.new(
                              name: 'Name',
                              description: 'Description'
    ))
  end

  it 'renders new group form' do
    render

    assert_select 'form[action=?][method=?]', account_groups_path(@account), 'post' do
      assert_select 'input[name=?]', 'group[name]'

      assert_select 'input[name=?]', 'group[description]'
    end
  end
end
