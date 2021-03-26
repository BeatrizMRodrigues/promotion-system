require 'test_helper'

class PromotionsFlow < ActionDispatch::IntegrationTest
  test 'can create a promotion' do
    login_user
    post '/promotions', params: { promotion: { name: 'Natal', description:'Promoção de natal', code: 'NATAL10', discount_rate: 10, coupon_quantity: 5, expiration_date: '25/12/2021'} }

    assert_redirected_to promotion_path(Promotion.last)
    follow_redirect!
    assert_select 'h3', 'Natal'
  end

  test 'cannot create a promotion without login' do
    post '/promotions', params: { promotion: { name: 'Natal', description:'Promoção de natal', code: 'NATAL10', discount_rate: 10, coupon_quantity: 5, expiration_date: '25/12/2021'} }

    assert_redirected_to new_user_session_path
  end

  test 'cannot generate coupons without login' do
    
  end
end