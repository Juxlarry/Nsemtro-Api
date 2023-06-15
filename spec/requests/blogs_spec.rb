require 'rails_helper'

RSpec.describe "Blogs", type: :request do
 
  let!(:blogs) {create_list(:blog, 10) }
  let(:blog_id) {blogs.first.id}
  let(:user) { FactoryBot.create(:user) }

  #TEST to Get blogs
  describe "GET /blogs" do
    
    before { 
      login(user) 
      init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

      auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

      get '/api/v1/blogs' , headers: auth_headers
    }

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end 

    it 'returns blogs' do 
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end 
  end

  
  #Test Get a Blog 
  describe "GET /blogs/:id" do

    before { 
      login(user) 
      init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

      get "/api/v1/blogs/#{blog_id}", headers: auth_headers
    }

    context "when the blog exists" do 

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
      
      it 'returns the blog' do 
        expect(json).not_to be_empty
        expect(json['id']).to eq(blog_id)
      end 
    end

    context 'when the blog does not exist' do 
      let(:newblog_id) { 0 }

      before {
        init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

        get "/api/v1/blogs/#{newblog_id}", headers: auth_headers
      }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end 

      it 'returns a not found message' do 
        expect(response.body).to include("Couldn't find Blog with 'id'=0")
      end 
    end 
  end


  #Test to CREATE Blog
  describe 'POST /blog' do 
    let!(:category) {FactoryBot.create(:category)}
    let(:user) {FactoryBot.create(:user)}
    let(:blog_params) {
      {
        title: 'Liverpool win the quadruple', 
        content: 'Liverpool FC have today set a new record by winning a record 4 trophies in a season',
        author: user.username, 
        category_id: category.id
      }.to_json
    }

  
    context 'when the param attributes are valid' do 
      before { 
        login(user) 
        init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

        post '/api/v1/blogs', params: blog_params, headers: auth_headers 
      }

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end 

      it 'creates a blog' do 
        expect(json['title']).to eq('Liverpool win the quadruple')
        expect(json['content']).to include('Liverpool FC have today set a new record')
        expect(json['author']).to eq(user.username)
      end 
    end

    context 'when the param attributes are invalid' do 

      before { 
        login(user) 
        init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

        post '/api/v1/blogs', params: {}, headers: auth_headers 
      }

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end 

      it 'fails validation checks' do 
        expect(response.body).to include("can't be blank")
      end 
    end 
  end


  #Test Update Blog
  describe 'PUT /blogs/:id' do
    let(:valid_attributes) { { title: 'Anfield Erupts' }.to_json }

    before { 
      login(user)

      init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

      put "/api/v1/blogs/#{blog_id}", params: valid_attributes, headers: auth_headers
    }

    context 'when blog exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the blog' do
        updated_item = Blog.find(blog_id)
        expect(updated_item.title).to match(/Anfield Erupts/)
      end
    end

    context 'when the blog does not exist' do

      before { 
        login(user)

        init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

        put "/api/v1/blogs/0", params: valid_attributes, headers: auth_headers 
      }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Blog with 'id'=0")
      end
    end
  end

  #Test DELETE Blog
  describe 'DELETE /blog/:id' do 

    before {
      login(user)
      init_headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(init_headers, user)

      delete "/api/v1/blogs/#{blog_id}", headers: auth_headers
    }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end 
  end 
end