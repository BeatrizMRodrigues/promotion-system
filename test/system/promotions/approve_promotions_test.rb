require 'application_system_test_case'

class ApprovePromotionsTest < ApplicationSystemTestCase
  test 'user approves promotion' do
    user = User.create!(email: 'john.doe@iugu.com.br', password: '123dasP**')
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '25/12/2021', user: user)

    approver = login_user
    visit promotion_path(christmas)
    accept_confirm { click_on 'Aprovar' }

    assert_text 'Promoção aprovada'
    assert_text "Aprovada por #{approver.email}"
    assert_link 'Gerar cupons'
    refute_link 'Aprovar'
  end

  test 'user can not approves his promotions' do
    user = login_user
    christmas = Promotion.create!(name: 'Natal',
                                  description: 'Promoção de Natal',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100,
                                  expiration_date: '22/12/2033', user: user)

    visit promotion_path(christmas)

    refute_link 'Aprovar'
    refute_link 'Gerar cupons'
  end
end