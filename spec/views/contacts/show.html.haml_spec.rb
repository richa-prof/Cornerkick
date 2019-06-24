require 'rails_helper'

RSpec.describe 'contacts/show', type: :view do
  before(:each) do
    @account = assign(:account, Fabricate(:account))
    @contact = assign(:contact, Fabricate(:contact,
                                          first_name: 'First Name',
                                          last_name: 'Last Name',
                                          email: 'Email',
                                          phone: 'Phone',
                                          account: @account))
    @current_account = @account
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone/)
  end
end
