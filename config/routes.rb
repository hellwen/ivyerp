Ivyerp::Application.routes.draw do
  # Root
  root :to => "overview#index"

  # I18n
  filter 'locale'

  # Authorization
  devise_for :users

  resources :users do
    collection do
      get :current
    end
  end

  resources :jobs

  resources :departments

  resources :employees

  resources :customers do
    member do
      get :copy
      get :new_customer_shipping
      get :new_customer_contact
    end

    collection do
      get :new_customer_shipping
      get :new_customer_contact
    end
  end

  resources :products

  resources :stocks do
    collection do
      get :inventory
    end 
  end

  resources :stock_ins do
    member do
      get :new_stock_product
    end
    collection do
      get :new_stock_product
    end
  end

  resources :stock_outs do
    member do
      get :new_stock_product
    end
    collection do
      get :new_stock_product
    end
  end
  
  resources :stock_locations

end
