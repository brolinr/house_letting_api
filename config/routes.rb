Rails.application.routes.draw do
  
  resources :amounts, only: :new
  resources :subscriptions, only: :new
  resources :customers, only: :new
  resources :users, only: :new
  resources :properties

end
