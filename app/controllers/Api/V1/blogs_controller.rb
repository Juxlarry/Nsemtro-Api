class Api::V1::BlogsController < ApplicationController
    before_action :set_blog, only: %i[show update destroy]

    #Get /Blogs
    def index 
        @blogs = Blog.all
        render json: BlogsRepresenter.new(@blogs).as_json
    end 

    #POST /blog
    def create 
        @blog = Blog.create(blog_params)

        if @blog.save 
            render json: BlogRepresenter.new(@blog).as_json, status: :created
        else
            render json: @blog.errors, status: :unprocessable_entity
        end
    end 


    #GET /blog/:id
    def show 
        render json: BlogRepresenter.new(@blog).as_json
    end 


    #PUT /blog/:id
    def update 
        if @blog.update(blog_params)
            head :no_content
        else  
            render json: @blog.errors, status: :unprocessable_entity
        end 
    end


    #DELETE /blog/:id
    def destroy 
        @blog.destroy
        head :no_content
    end 

    
    private 

    def blog_params 
        params.permit(:title,:content,:author,:category_id)
    end 

    def set_blog
        @blog = Blog.find(params[:id])
    end 
end
