require 'application_system_test_case'

class ProductCategoriesTest < ApplicationSystemTestCase
    
    test 'view categories' do
     ProductCategory.create!(name: 'Produto AntiFraude', 
                            code: 'ANTIFRA')

     visit root_path
     click_on 'Categorias'

     assert_text 'Produto AntiFraude'
     assert_text 'ANTIFRA'
    end

    test 'no category are available' do
     visit root_path
     click_on 'Categorias'

     assert_text 'Nenhuma categoria cadastrada'
    end

    test 'view category and return to home page' do 
     ProductCategory.create!(name: 'Produto AntiFraude', 
                            code: 'ANTIFRA')
    
     visit root_path
     click_on 'Categorias'
     click_on 'Voltar'

     assert_current_path root_path
    end

    test 'create category' do 
     visit root_path
     click_on 'Categorias'
     click_on 'Cadastrar nova categoria'
     fill_in 'Nome', with: 'Produto AntiFraude'
     fill_in 'Código', with: 'ANTIFRA'
     click_on 'Cadastrar'

     assert_current_path product_category_path(ProductCategory.last)
     assert_text 'Produto AntiFraude'
     assert_text 'ANTIFRA'
     assert_link 'Voltar'
    end
end