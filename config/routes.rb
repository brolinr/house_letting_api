Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      resources :feedbacks
      resources :amounts
      resources :subscriptions
      resources :customers
      resources :users
      resources :properties
    end

    namespace :v2 do
      resources :customers, only: [:create, :update, :destroy]
      resources :admins, only: [:create, :update, :destroy]
      resources :subscriptions, only: :create
      resources :houses, only: [:create, :update, :destroy, :index, :show]
      resources :amounts, only: [:create, :index]
      resources :feedbacks, only: [:create, :index, :show]
    end
  end
end
