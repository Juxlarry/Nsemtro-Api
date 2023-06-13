require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  
  describe "POST /login" do
    context "when user attributes are valid" do
      it 'authenticates the user' do 
        # puts "User  created :\n #{user.username} | #{user.name} | #{user.email} \n"
        post '/api/v1/login', params:  { name: user.name, username: user.username, email: user.email, password: user.password} 
        expect(response).to have_http_status(:created)
        expect(json['username']).to eq(user.username)
        expect(json['token']).to eq("#{AuthenticationTokenService.call(User.last.id)}")
      end 
    end 

    context 'when user attributes are invalid' do 
      it 'returns error when username does not exist' do
        post '/api/v1/login', params: { username: "#{Faker::Internet.username}", password: 'password'}
        # puts "User  params passed: #{params.username} | #{params.password}"

        expect(response).to have_http_status(:unauthorized)
        expect(json).to eq(
          {
            'error'=> 'No such user'
          }
        )
      end 

      it 'returns error when password is incorrect' do 
        post '/api/v1/login', params: { username: user.username, password: 'wrong'}
        # puts "User  params passed: #{params.username} | #{params.password}"

        expect(response).to have_http_status(:unauthorized)
        expect(json).to eq(
          {
            'error'=> 'Incorrect password'
          }
        )
      end 
    end 
  end
end
