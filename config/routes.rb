Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  

  resources :promotions do
    post 'generate_coupons', on: :member
    post 'approve', on: :member
    get 'search', on: :collection
    get 'account_detail', on: :member
  end

  resources :product_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :coupons, only: [:show] do 
   post 'disable', on: :member
   post 'active', on: :member
   get 'search', on: :collection
  end 

  namespace :api, constraints: ->(req) { req.format == :json } do
    namespace :v1 do
      resources :coupons, only: [:show], param: :code 
    end
  end

end
