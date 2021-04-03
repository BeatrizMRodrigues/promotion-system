Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'search', to: "home#search"

  resources :promotions, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    post 'generate_coupons', on: :member
    post 'approve', on: :member
  end

  resources :product_categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :coupons, only: [] do 
   post 'disable', on: :member
   post 'active', on: :member
  end 

  namespace :api do
    namespace :v1 do
      resources :coupons, only: [:show], param: :code 
    end
  end

end
