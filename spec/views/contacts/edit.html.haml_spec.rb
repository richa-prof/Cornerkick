require 'rails_helper'

RSpec.describe 'contacts/edit', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @contact = assign(:contact, Fabricate(:contact, account: @account))
    @current_account = @account
  end

  it 'renders the edit contact form' do
    render

    assert_select 'form[action=?][method=?]', account_contact_path(@account, @contact), 'post' do
      assert_select 'input#contact_first_name[name=?]', 'contact[first_name]'

      assert_select 'input#contact_last_name[name=?]', 'contact[last_name]'

      assert_select 'input#contact_email[name=?]', 'contact[email]'

      assert_select 'input#contact_phone[name=?]', 'contact[phone]'
    end
  end
end
