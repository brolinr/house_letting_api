Rails.application.routes.draw do
  resources :amounts
  resources :subscriptions
  resources :customers
  resources :users
  resources :properties do
    get :image, on: :member
  end
  
end
