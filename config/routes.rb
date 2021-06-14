Rails.application.routes.draw do
  root 'welcome#index'
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

    namespace :reports do
      resources :manifests
    end

    resources :motors, only: %i[index destroy create update] do
      get :validate_plate_number, on: :collection
    end
    resources :people
    resources :manifests do
      get :download_manifest, on: :member
    end
    resources :terminals
    resources :companies
    resources :manifest_people
    resources :tickets, only: %i[] do
      post :create_ticket, on: :collection
      put :update_ticket, on: :collection
    end
  end
end
