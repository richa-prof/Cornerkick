require 'rails_helper'

RSpec.describe 'contacts/new', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    assign(:contact, Contact.new(
                       first_name: 'MyString',
                       last_name: 'MyString',
                       email: 'MyString',
                       phone: 'MyString',
                       account: nil
    ))
    @current_account = @account
  end

  it 'renders new contact form' do
    render

    assert_select 'form[action=?][method=?]', account_contacts_path(@account), 'post' do
      assert_select 'input#contact_first_name[name=?]', 'contact[first_name]'

      assert_select 'input#contact_last_name[name=?]', 'contact[last_name]'

      assert_select 'input#contact_email[name=?]', 'contact[email]'

      assert_select 'input#contact_phone[name=?]', 'contact[phone]'
    end
  end
end
