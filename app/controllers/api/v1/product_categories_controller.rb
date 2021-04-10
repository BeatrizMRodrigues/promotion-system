class Api::V1::ProductCategoriesController < Api::V1::ApiController
  def show
    @product_category = ProductCategory.find_by!(code: params[:code])
  end

  def create
    @product_category = ProductCategory.new(params.require(:product_category).permit(:name, :code))
    if @product_category.save
      render json: @product_category
    else
      render json: @product_category.errors
    end
  end

  def update
  end

  def destroy
  end
end