class Api::V1::BlogsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_blog, only: %i[show update destroy]

    #Get /Blogs
    def index 
        @blogs = Blog.all
        render json: BlogsRepresenter.new(@blogs).as_json
    end 

    #POST /blog
    def create 
        @blog = Blog.new(blog_params)
        
        logger.info "Blog - #{@blog.inspect}"
        logger.info "Blog params - #{blog_params}"
        
        @blog.blog_images.attach(params[:blog_images])
        
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
        logger.info "blog before update - #{@blog.inspect}"
        if @blog.update(blog_params)
            logger.info "blog after update - #{@blog.inspect}"
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
        if current_user
            params[:author] = current_user.username
            params[:user_id] = current_user.id
        end
        params.permit(:title, :content, :author, :category_id, :user_id, blog_images:[])
    end 

    def set_blog
        @blog = Blog.find(params[:id])
    end 
end
