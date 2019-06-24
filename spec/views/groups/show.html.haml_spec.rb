require 'rails_helper'

RSpec.describe 'groups/show', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @group = assign(:group, Fabricate(:group,
                                      name: 'Name',
                                      description: 'Description',
                                      account: @account))
    @contacts = assign(:contacts, Kaminari.paginate_array([]).page(1).per(10))
    @current_account = @account
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
