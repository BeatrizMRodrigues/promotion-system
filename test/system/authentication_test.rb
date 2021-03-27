require 'application_system_test_case'

 class AuthenticationTest < ApplicationSystemTestCase
   test 'user sign up' do
     visit root_path
     click_on 'Cadastrar'
     fill_in 'Email', with: 'jane.doe@iugu.com.br'
     fill_in 'Senha', with: 'password'
     fill_in 'Confirmação de senha', with: 'password'
     within 'form' do
       click_on 'Cadastrar'
     end

     assert_text 'Boas vindas! Cadastrou e entrou com sucesso'
     assert_text 'jane.doe@iugu.com.br'
     assert_link 'Sair'
     assert_no_link 'Cadastrar'
     assert_current_path root_path
   end

   # test 'user sign up' do
   #   visit root_path
   #   click_on 'Cadastrar'
   #   within 'form' do
   #     click_on 'Cadastrar'
   #   end

   #   assert_text 'Senha não pode ficar em branco'
   #   assert_text 'Email não pode ficar em branco'
   # end

   test 'user sign in' do
     user = User.create!(email: 'jane.doe@iugu.com.br', password: 'password')

     visit root_path
     click_on 'Entrar'
     fill_in 'Email', with: user.email
     fill_in 'Senha', with: user.password
     click_on 'Log in'

     assert_text 'Login efetuado com sucesso!'
     assert_text user.email
     assert_current_path root_path
     assert_link 'Sair'
     assert_no_link 'Entrar'
   end

   test 'user sign out' do
    login_user
    visit root_path
    click_on 'Sair'

    assert_no_link 'Sair'
    assert_text 'Entrar'
    assert_no_text 'Olá'
   end

   
   # TODO: Teste de falha ao registrar
   # TODO: Teste de falha ao logar
   # TODO: Teste o recuperar senha
   # TODO: Teste o editar o usuário
   # TODO: I18n do user
   # TODO: incluir name no user
   # TODO: confirmar a conta
   # TODO: mandar email
   # TODO: validar a qualidade da senha
   # TODO: captcha não sou um robô
 end