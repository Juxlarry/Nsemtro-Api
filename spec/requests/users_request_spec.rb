require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /signup" do
    it 'authenticates the user' do 
      post '/api/v1/signup', params: {user: { name: 'Kwame Zulu', username: 'kwamzzz1', email: 'kzalu@lulu.com', password: 'password'} } 
      expect(response).to have_http_status(:created)
      expect(json['username']).to eq('kwamzzz1')
      expect(json['token']).to eq("#{AuthenticationTokenService.call(User.last.id)}")
    end 
  end
end
