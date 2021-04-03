require 'test_helper'

class PromotionsAPI < ActionDispatch::IntegrationTest
  test 'show coupon' do
    user = User.create!(email: 'test@iugu.com.br', password: 'Password123-')
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 10,
                                  expiration_date: '25/12/2021', user: user)

    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)

    get "/api/v1/coupons/#{coupon.code}"

    assert_response :success
    body = JSON.parse(response.body, symbolize_names: true)
    assert_equal coupon.code, body[:code]
  end  
end