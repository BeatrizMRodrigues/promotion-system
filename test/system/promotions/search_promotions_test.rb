require 'application_system_test_case'

class SearchPromotionsTest < ApplicationSystemTestCase
  test 'search for exact term' do 
    user = login_user 
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10,
                      coupon_quantity: 20, expiration_date: '25/12/2023', user: user)

    Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                      code: 'CARNA15', discount_rate: 15,
                      coupon_quantity: 20, expiration_date: '25/02/2023', user: user)

                            
    visit root_path
    fill_in 'Buscar', with: 'Natal'
    click_on 'Pesquisar'

    assert_text 'Natal'
    assert_no_text 'Carnaval'
  end
end