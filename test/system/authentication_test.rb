require 'application_system_test_case'

class AuthenticationTest < ApplicationSystemTestCase
  test 'user sign up' do
    visit root_path
    click_on 'Registrar'
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Registrar'

    assert_text 'Boas vindas! Cadastrou e entrou com sucesso'
    assert_text 'jane.doe@iugu.com.br'
    assert_link 'Sair'
    assert_no_link 'Cadastrar'
    assert_current_path root_path
  end
end