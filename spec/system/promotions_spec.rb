require 'rails_helper'

describe 'Promotions Test' do
  before do
    driven_by(:rack_test)
  end

  it 'view promotions' do
    user = Fabricate(:user)
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033', user: user)
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033', user: user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_text('Natal')
    expect(page).to have_text('Promoção de Natal')
    expect(page).to have_text('10,00%')
    expect(page).to have_text('Cyber Monday')
    expect(page).to have_text('Promoção de Cyber Monday')
    expect(page).to have_text('15,00%')
  end

  it 'generate coupons for a promotion' do
    user = Fabricate(:user)
    promotion = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)
    promotion.create_promotion_approval(
      user: User.create!(email: 'john.doe@iugu.com.br', password: '125**9Pp')
    )

    login_as user, scope: :user
    visit promotion_path(promotion)
    click_on 'Gerar cupons'

    expect(page).to have_text('Cupons gerados com sucesso')
    expect(page).not_to have_link('Gerar cupons')
    expect(page).not_to have_text('NATAL10-0000')
    expect(page).to have_text('NATAL10-0001')
    expect(page).to have_text('NATAL10-0002')
    expect(page).to have_text('NATAL10-0099')
    expect(page).to have_text('NATAL10-0100')
    expect(page).not_to have_text('NATAL10-0101')
  end

  it 'edit promotion' do
    user = Fabricate(:user)
    promotion = Fabricate(:promotion)
    
    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Editar promoção'

    fill_in 'Nome', with: 'Carnaval'
    fill_in 'Descrição', with: 'Promoção de carnaval'
    fill_in 'Código', with: 'CARNA25'
    fill_in 'Desconto', with: '25'
    fill_in 'Quantidade de cupons', with: '250'
    fill_in 'Data de término', with: '22/02/2022'
    click_on 'Salvar'

    expect(page).to have_current_path(promotion_path(Promotion.last))
    expect(page).to have_text('Carnaval')
    expect(page).to have_text('Promoção de carnaval')
    expect(page).to have_text('CARNA25')
    expect(page).to have_text('25,00%')
    expect(page).to have_text('250')
    expect(page).to have_text('22/02/2022')
    expect(page).to have_text('Voltar')
  end
end