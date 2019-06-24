require 'rails_helper'

RSpec.describe 'groups/index', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    groups = [
      Fabricate(:group,
                name: 'Name',
                description: 'Description',
                account: @account),
      Fabricate(:group,
                name: 'Name',
                description: 'Description',
                account: @account)
    ]
    groups = Kaminari.paginate_array(groups).page(1).per(10)
    assign(:groups, groups)
  end

  it 'renders a list of groups' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Description'.to_s, count: 2
  end
end
