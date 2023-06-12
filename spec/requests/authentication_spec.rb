require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /login" do
    it 'authenticates the user' do 
      post '/api/v1/login', params:  { name: 'Kwame Zalu', username: 'Kzalulo', password: 'password'} 
      expect(response).to have_http_status(200)
      expect(json['username']).to eq('Kzalulo')
      expect(json['token']).to eq("#{AuthenticationTokenService.call(User.last.id)}")
    end 
  end
end
