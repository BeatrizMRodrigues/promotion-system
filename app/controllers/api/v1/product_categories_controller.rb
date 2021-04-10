class Api::V1::ProductCategoriesController < Api::V1::ApiController
  def show
    @product_category = ProductCategory.find_by!(code: params[:code])
  end
end