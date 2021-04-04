require 'application_system_test_case'

 class AuthenticationTest < ApplicationSystemTestCase
   test 'user sign up' do
     visit root_path
     click_on 'Cadastrar'
     fill_in 'Username', with: 'Jane'
     fill_in 'Email', with: 'jane.doe@iugu.com.br'
     fill_in 'Senha', with: 'Password12*'
     fill_in 'Confirmação de senha', with: 'Password12*'
     within 'form' do
       click_on 'Cadastrar'
     end

     assert_text 'Boas vindas! Cadastrou e entrou com sucesso'
     assert_text 'Jane'
     assert_link 'Sair'
     assert_no_link 'Cadastrar'
     assert_current_path root_path
   end

   test 'user cannot sign up' do
      visit root_path
      click_on 'Cadastrar'
      within 'form' do
        click_on 'Cadastrar'
      end

      assert_text 'Senha não pode ficar em branco'
      assert_text 'Email não pode ficar em branco'
    end

   test 'user sign in' do
     user = User.create!(username: 'JaneDoe', email: 'jane.doe@iugu.com.br', password: 'Password12*')

     visit root_path
     click_on 'Entrar'
     fill_in 'Login', with: user.username
     fill_in 'Senha', with: user.password
     click_on 'Log in'

     assert_text 'Login efetuado com sucesso!'
     assert_text user.username
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

   test 'user cannot sign in' do
    user = User.create!(email: 'jane.doe@iugu.com.br', password: 'Password12*')

    visit root_path
    click_on 'Entrar'
    fill_in 'Login', with: 'janedoe@iugu.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    assert_no_text 'Login efetuado com sucesso!'
    assert_text 'Login ou senha inválida.'
   end

   test 'password complexity' do 
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Username', with: 'Jane'
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: 'Password12*'
    fill_in 'Confirmação de senha', with: 'Password12*'
    within 'form' do
      click_on 'Cadastrar'
    end

    assert_text 'Boas vindas! Cadastrou e entrou com sucesso'
    assert_text 'Jane'
    assert_link 'Sair'
    assert_no_link 'Cadastrar'
    assert_current_path root_path
   end
   
   test 'password complexity failures' do 
    visit root_path
    click_on 'Cadastrar'
    fill_in 'Username', with: 'Jane'
    fill_in 'Email', with: 'jane.doe@iugu.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmação de senha', with: 'password'
    within 'form' do
      click_on 'Cadastrar'
    end

    assert_no_text 'Boas vindas! Cadastrou e entrou com sucesso'
    assert_no_text 'Jane'
    assert_no_link 'Sair'
    assert_text 'A senha deve conter no mínimo 8 caracteres, com pelo menos 1 letra maiúscula, 1 letra minúscula e 1 caractere especial'
   end

   test 'user forgot password' do
    user = User.create!(username: 'Jane', email: 'jane.doe@iugu.com.br', password: 'Password12*')

    visit root_path
    click_on 'Entrar'
    fill_in 'Login', with: 'janedoe@iugu.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Forgot your password?'
    
    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)

    assert_no_text 'Login efetuado com sucesso!'
    assert_text 'New password'
   end

   test 'user edit password' do 
    user = User.create!(username: 'Jane', email: 'jane.doe@iugu.com.br', password: 'Password12*')
    token = user.send_reset_password_instructions
    visit edit_user_password_path(reset_password_token: token)

    fill_in 'New password', with: '1135*pP0'
    fill_in 'Confirm new password', with: '1135*pP0'
    click_on 'Change my password'

    assert_text 'Jane'
    assert_text 'Promoções'

   end
   
   # TODO: I18n do user
   # TODO: confirmar a conta
   # TODO: mandar email
   # TODO: captcha não sou um robô
 end