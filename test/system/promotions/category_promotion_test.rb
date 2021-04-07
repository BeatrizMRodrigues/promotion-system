require 'application_system_test_case'

class CategoryPromotionsTest < ApplicationSystemTestCase
  test 'create promotion with category' do
    product_category = ProductCategory.create(name: 'Anti Fraude', code: 'ANTIFRA')

    login_user
    visit root_path
    click_on 'Promoções'
    #TODO: continuar tarefa aqui
  end
end