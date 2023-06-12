require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:categories) {create_list(:category, 5) }
  let!(:category_id) { categories.first.id }
  

  #Test Get all Categories 
  describe "GET /categories" do
    before {get '/api/v1/categories'}
      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
      
      it 'returns categories' do 
        expect(json).to_not be_empty
        expect(json.size).to eq(5)
      end 
  end

  #Test Get a Category 
  describe "GET /categories/:id" do
    before {get "/api/v1/categories/#{category_id}"}
    
    context "when the category exists" do 
      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
      
      it 'returns the category' do 
        expect(json).to_not be_empty
        expect(json['id']).to eq(category_id)
      end 
    end
  end

  #Test CREATE a Category
  describe "POST /category" do
    let(:category_name) { { name: 'Sports' } }

    context 'when the request is valid' do 
      before {post '/api/v1/categories', params: category_name}

      it 'creates a category' do 
        expect(json['name']).to eq('Sports')
      end 

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end 
    end 

    context 'when the request is invalid' do 
      before {post '/api/v1/categories', params: {name: ''}}

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end 

      it 'returns a validation failure message' do 
        expect(response.body).to include("is too short (minimum is 3 characters)")
      end 
    end 
  end 

  #Test DELETE Category
  describe 'DELETE /categories/:id' do 
    before {delete "/api/v1/categories/#{category_id}"}

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end 
  end 

end
