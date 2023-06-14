class Api::V1::CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_category, only: %i[show destroy] 
    #GET /Categories 
    def index 
        @categories = Category.all 
        render json: CategoriesRepresenter.new(@categories).as_json
    end 

    #CREATE /Category
    def create
        @category = Category.create(category_params)
        if @category.save 
            render json: CategoryRepresenter.new(@category).as_json, status: :created
        else 
            render json: @category.errors, status: :unprocessable_entity
        end 
    end 

    def show 
        render json: CategoryRepresenter.new(@category).as_json
    end 

    #DELETE /Categories/:id
    def destroy
        @category.destroy
        head :no_content
    end 

    private 

    def category_params 
        params.permit(:name)
    end 

    def set_category 
        @category = Category.find(params[:id])
    end 
end
