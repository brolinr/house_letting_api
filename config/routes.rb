Rails.application.routes.draw do
  resources :feedbacks
  resources :amounts
  resources :subscriptions
  resources :customers
  resources :users
  resources :properties
  get "/", to: "application#home"
end
