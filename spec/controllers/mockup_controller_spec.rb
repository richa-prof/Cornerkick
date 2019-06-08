require 'rails_helper'

RSpec.describe MockupController, type: :controller do

  describe "GET #mockup" do
    it "returns http success" do
      get :mockup
      expect(response).to have_http_status(:success)
    end
  end

end
