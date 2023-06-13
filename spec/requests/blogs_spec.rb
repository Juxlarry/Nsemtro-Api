require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let!(:blogs) {create_list(:blog, 10) }
  let(:blog_id) {blogs.first.id}
  let(:user) { FactoryBot.create(:user, name: 'Larry Jay', username: 'Larry1', email: 'testLarry1@mailer.com', password: 'password')}
  #TEST to Get blogs
  describe "GET /blogs" do
    
    before { get '/api/v1/blogs',  headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }}

    it 'returns status code 200' do 
      puts "#{response.status}"
      expect(response).to have_http_status(200)
    end 

    it 'returns blogs' do 
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end 
  end

  #Test Get a Blog 
  describe "GET /blogs/:id" do
    before {get "/api/v1/blogs/#{blog_id}", headers: {
      'Authorization' => AuthenticationTokenService.call(user.id)
    }}
    
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

      before {get "/api/v1/blogs/#{newblog_id}", headers: {
        'Authorization' => AuthenticationTokenService.call(user.id)
      }}

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
    # let(:user) {FactoryBot.create(:user)}
    let(:blog_params) {
      {
        title: 'Liverpool win the quadruple', 
        content: 'Liverpool FC have today set a new record by winning a record 4 trophies in a season',
        author: 'Larry Jay', 
        category_id: category.id, 
      }
    }
    
    context 'when the param attributes are valid' do 
      before {post '/api/v1/blogs', params: blog_params, headers: {
        'Authorization' => AuthenticationTokenService.call(user.id)
      }}

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end 

      it 'creates a blog' do 
        expect(json['title']).to eq('Liverpool win the quadruple')
        expect(json['content']).to include('Liverpool FC have today set a new record')
        expect(json['author']).to eq('Larry Jay')
      end 
    end

    context 'when the param attributes are invalid' do 

      before {post '/api/v1/blogs', params: {}, headers: {
        'Authorization' => AuthenticationTokenService.call(user.id)
      }}

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end 

      it 'fails validation checks' do 
        expect(response.body).to include("can't be blank")
      end 
    end 
  end

  # #Test Update Blog
  describe 'PUT /blogs/:id' do
    let(:valid_attributes) { { title: 'Anfield Erupts' } }

    before { put "/api/v1/blogs/#{blog_id}", params: valid_attributes, headers: {
      'Authorization' => AuthenticationTokenService.call(user.id)
    }}

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
      let(:blog_id) { 0 }

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
    before {delete "/api/v1/blogs/#{blog_id}", headers: {
      'Authorization' => AuthenticationTokenService.call(user.id)
    }}

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end 
  end 
end
