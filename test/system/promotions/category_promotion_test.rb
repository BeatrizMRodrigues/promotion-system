require 'application_system_test_case'

class CategoryPromotionsTest < ApplicationSystemTestCase
  test 'create promotion with category' do
    product_category = ProductCategory.create(name: 'Anti Fraude', code: 'ANTIFRA')

    login_user
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check  product_category.name
    click_on 'Criar Promoção'

    assert_current_path promotion_path(Promotion.last)
    assert_text 'Cyber Monday'
    assert_text 'Promoção de Cyber Monday'
    assert_text '15,00%'
    assert_text 'CYBER15'
    assert_text '22/12/2033'
    assert_text '90'
    assert_text product_category.name
    assert_link 'Voltar'
  end

  test 'edit promotion with category' do
    product_category = ProductCategory.create(name: 'Anti Fraude', code: 'ANTIFRA')
    user = login_user
    Promotion.create!(name: 'Carnaval', description: 'Promoção de carnaval',
                      code: 'CARNA20', discount_rate: 20, coupon_quantity: 200,
                      expiration_date: '20/02/2022', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Carnaval'
    click_on 'Editar promoção'

    fill_in 'Nome', with: 'Carnaval'
    fill_in 'Descrição', with: 'Promoção de carnaval'
    fill_in 'Código', with: 'CARNA25'
    fill_in 'Desconto', with: '25'
    fill_in 'Quantidade de cupons', with: '250'
    fill_in 'Data de término', with: '22/02/2022'
    check product_category.name
    click_on 'Salvar'

    assert_current_path promotion_path(Promotion.last)
    assert_text 'Carnaval'
    assert_text 'Promoção de carnaval'
    assert_text 'CARNA25'
    assert_text '25,00%'
    assert_text '250'
    assert_text '22/02/2022'
    assert_text 'Anti Fraude'
    assert_text 'Voltar'
  end
end