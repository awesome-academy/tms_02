Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"

    devise_for :users
    resources :users, except: [:destroy]
    namespace :admin do
      resources :courses
      resources :users
      resources :subjects
    end
  end
end
