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

  resources :jobs do
  end

  resources :departments do
  end

  resources :employees do
  end

  resources :customers do
    member do
      get :letter
      get :copy
    end

    member do
      get :new_customer_shipping
      get :new_customer_contact
    end
    collection do
      get :new_customer_shipping
      get :new_customer_contact
    end
  end

  resources :products do
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
  resources :stock_locations do
  end
end
