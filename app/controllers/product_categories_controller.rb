class ProductCategoriesController < ApplicationController
    def index
        @product_categories = ProductCategory.all
    end

    def new
        @product_category = ProductCategory.new
    end

    def show
        @product_category = ProductCategory.find(params[:id])
    end

    def create
        @product_category = ProductCategory.new(params.require(:product_category).permit(:name, :code))
        if @product_category.save
            redirect_to @product_category
        else
            render :new
        end
    end

    def edit
        @product_category = ProductCategory.find(params[:id])
    end

    def update
        @product_category = ProductCategory.find(params[:id])
        @product_category = ProductCategory.update(params.require(:product_category).permit(:name, :code))
        redirect_to @product_category
    end
end
