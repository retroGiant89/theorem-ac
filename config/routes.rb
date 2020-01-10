Rails.application.routes.draw do
  resources :statuses do
    post 'bulk_create', on: :collection
  end
  devise_for :admins
  resources :devices
  resources :admins, except: [:new, :create]
  root to: 'devices#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
