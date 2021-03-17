Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :v1 do
    post 'sessions/register', to: 'sessions#register'
    post 'sessions/login', to: 'sessions#login'

    resources :terminals
  end
end
