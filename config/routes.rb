Rails.application.routes.draw do
  resources :statuses, only: [:create, :show] do
    post 'bulk_create', on: :collection
  end
  devise_for :admins
  resources :devices, only: [:index, :create, :show]
  resources :admins, except: [:new, :create]
  resources :notifications, only: [:index, :destroy]
  root to: 'devices#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
