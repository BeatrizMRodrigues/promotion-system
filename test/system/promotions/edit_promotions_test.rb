require 'application_system_test_case'

class EditPromotionsTest < ApplicationSystemTestCase
  test 'edit promotion' do 
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
    click_on 'Salvar'

    assert_current_path promotion_path(Promotion.last)
    assert_text 'Carnaval'
    assert_text 'Promoção de carnaval'
    assert_text 'CARNA25'
    assert_text '25,00%'
    assert_text '250'
    assert_text '22/02/2022'
    assert_text 'Voltar'
  end
end