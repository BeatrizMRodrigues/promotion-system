require 'test_helper'

class ProductCategoryAPI < ActionDispatch::IntegrationTest
  test 'show product category' do
    product_category = ProductCategory.create!(name: 'Anti Fraude', code: 'ANTIFRA')

    get "/api/v1/product_categories/#{product_category.code}", as: :json

    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)
  end

  test 'show product category not found' do
    get '/api/v1/product_categories/0', as: :json

    assert_response :not_found
  end
end