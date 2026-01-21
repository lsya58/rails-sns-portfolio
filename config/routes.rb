Rails.application.routes.draw do
  root "static_pages#home"
  get "/settings", to: "static_pages#settings"
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
end