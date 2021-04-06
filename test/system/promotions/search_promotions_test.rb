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
    click_on 'Promoções'
    fill_in 'Buscar', with: 'Natal'
    click_on 'Pesquisar'

    assert_text 'Natal'
    assert_no_text 'Carnaval'
  end

  test 'search promotions and finds results' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
    xmas = Promotion.create!(name: 'Natalina', description: 'Promoção de Natal',
                             code: 'NATAL11', discount_rate: 10,
                             coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                     description: 'Promoção de Cyber Monday', code: 'CYBER15',
                                     discount_rate: 15, expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    fill_in 'Buscar', with: 'natal'
    click_on 'Pesquisar'

    assert_text christmas.name
    assert_text xmas.name
    refute_text cyber_monday.name
    assert_text '2 promoções encontradas para o termo: natal'
  end

  test 'search promotions and finds one result' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                     description: 'Promoção de Cyber Monday',
                                     code: 'CYBER15', discount_rate: 15,
                                     expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    fill_in 'Buscar', with: 'natal'
    click_on 'Pesquisar'

    assert_text christmas.name
    refute_text cyber_monday.name
    assert_text '1 promoção encontrada para o termo: natal'
  end

  test 'search promotions and do not find results' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    xmas = Promotion.create!(name: 'Natalina', description: 'Promoção de Natal',
                             code: 'NATAL11', discount_rate: 10, coupon_quantity: 100,
                             expiration_date: '22/12/2033', user: user)
    cyber_monday = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                                     description: 'Promoção de Cyber Monday',
                                     code: 'CYBER15', discount_rate: 15,
                                     expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    fill_in 'Buscar', with: 'test'
    click_on 'Pesquisar'

    refute_text christmas.name
    refute_text xmas.name
    refute_text cyber_monday.name
    assert_text 'Nenhuma promoção encontrada para o termo: test'
  end
end
