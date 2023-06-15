require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Authentications", type: :request do
    let(:user) {FactoryBot.create(:user) }

    describe "POST /login" do
        context "when user attributes are valid" do
            before { login(user) }

            it 'returns status 200' do 
                expect(response).to have_http_status(200)
            end 

            it 'returns a token' do
                expect(response.headers['Authorization']).to be_present
            end
        end 

        context 'when user attributes are invalid' do 

            it 'returns error when username does not exist' do
                post '/api/v1/login', params: {
                    user: {
                        email: nil, 
                        password: user.password
                    }
                }
                expect(response).to have_http_status(:unauthorized)

            end 

            it 'returns error when password is incorrect' do 
                post '/api/v1/login', params: {
                    user: {
                        email: user.email, 
                        password: nil
                    }
                }
                expect(response).to have_http_status(:unauthorized)
                
            end 
        end 

        describe '/DELETE logout' do
            before { 
                login(user) 
                init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
                auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

                delete '/api/v1/logout', headers: auth_headers
            }
 
            it 'returns 200, no content' do
                expect(response).to have_http_status(200)
            end
        end 
    end
end