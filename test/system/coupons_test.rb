require 'application_system_test_case'

class CouponsTest < ApplicationSystemTestCase
  test 'disable a coupon' do
    user = login_user
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10',
                                  discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)

    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)

    visit promotion_path(promotion)
    click_on 'Desabilitar'

    assert_text "Cupom #{coupon.code} desabilitado com sucesso"
    assert_text "#{coupon.code} (desabilitado)"
  end

  test 'activate a coupon' do
    user = login_user
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10',
                                  discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)

    coupon = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)

    visit promotion_path(promotion)
    click_on 'Desabilitar'
    click_on 'Habilitar'

    assert_text "Cupom #{coupon.code} habilitado com sucesso"
    assert_no_text "#{coupon.code} (desabilitado)"
  end

  test 'search coupon' do
    user = login_user
    promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 20, expiration_date: '25/12/2023', user: user)

    coupon01 = Coupon.create!(code: 'NATAL10-0001', promotion: promotion)
    coupon02 = Coupon.create!(code: 'NATAL10-0002', promotion: promotion)
    coupon03 = Coupon.create!(code: 'NATAL10-0003', promotion: promotion)

    visit promotion_path(promotion)
    fill_in 'Buscar', with: 'NATAL10-0002'
    click_on 'Pesquisar'

    assert_text coupon02.code
    assert_text coupon02.status
    assert_text 'Promoção de Natal'
    assert_no_text 'NATAL10-0001'
    assert_no_text 'NATAL10-0003'
  end
end

#TODO: fazer o retorno de cupom inexistente
