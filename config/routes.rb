Rails.application.routes.draw do
  root "static_pages#index"

  devise_for :users
  resources :users, except: [:destroy]
  namespace :admin do
    resources :courses
    resources :users
  end
end
