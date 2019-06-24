require 'rails_helper'

RSpec.describe 'contacts/index', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @current_account = @account
    contacts = [
      Fabricate(:contact,
                first_name: 'First Name',
                last_name: 'Last Name',
                email: 'Email',
                phone: 'Phone',
                account: @account),
      Fabricate(:contact,
                first_name: 'First Name',
                last_name: 'Last Name',
                email: 'Email',
                phone: 'Phone',
                account: @account)
    ]
    contacts = Kaminari.paginate_array(contacts).page(1).per(10)
    assign(:contacts, contacts)
  end

  it 'renders a list of contacts' do
    render
    assert_select 'tr>td', text: 'First Name Last Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Email'.to_s, count: 2
    assert_select 'tr>td', text: 'Phone'.to_s, count: 2
  end
end
