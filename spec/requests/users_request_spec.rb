require 'rails_helper'

RSpec.describe "Users", type: :request do
    let(:user) { FactoryBot.build(:user) }
    let(:existing_user) {FactoryBot.create(:user) }

    describe "POST /signup" do
        context 'when the params are valid' do
            before {post '/api/v1/signup', params: {
                user: { 
                    name: user.name, 
                    username: user.username, 
                    email: user.email, 
                    signature: user.signature,
                    password: user.password
                }
            }} 

            it 'returns status 200' do 
                expect(response.status).to eq(200)
            end

            it 'returns a token' do 
                expect(response.headers['Authorization']).to be_present
            end 
        end

        context 'When an email already exists' do
            before do
              post '/api/v1/signup', params: {
                user: {
                    email: existing_user.email,
                    name: existing_user.name, 
                    username: existing_user.username, 
                    signature: existing_user.signature,
                    password: existing_user.password
                }
              }
            end
        
            it 'returns status code 422 user already exists' do
              expect(response.status).to eq(422)
            end
          end
    end
end