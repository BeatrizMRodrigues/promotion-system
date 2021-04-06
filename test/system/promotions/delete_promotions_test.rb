require 'application_system_test_case'

class DeletePromotionsTest < ApplicationSystemTestCase
  test 'delete promotion' do
    user = login_user
    Promotion.create!(name: 'Halloween', description: 'Promoção de Halloween',
                      code: 'HALLOWEEN15', discount_rate: 15, coupon_quantity: 150,
                      expiration_date: '01/11/2022', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Halloween'
    click_on 'Apagar promoção'

    assert_current_path root_path
  end
end
