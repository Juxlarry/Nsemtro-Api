require 'rails_helper'

RSpec.describe "CurrentUsers", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /current_user" do
    before {
      login(user)
      init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

      get '/current_user', headers: auth_headers
    }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns user' do 
      expect(json['username']).to eq(user.username)
    end 
  end
end
 