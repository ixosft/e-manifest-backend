Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :sessions do
    get :user, on: :collection
    post :login, on: :collection
    get :logout, on: :collection
    post :register, on: :collection
  end

  namespace :v1 do
    resources :users, only: %i[index update] do
      get :validate_username, on: :collection
    end

    resources :terminals
    resources :companies
  end
end
