Rails.application.routes.draw do
  resources :users
  resources :properties do
    get :image, on: :member
  end
  
end
