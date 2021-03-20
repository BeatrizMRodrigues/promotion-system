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
end