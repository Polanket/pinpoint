Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :users do
    resources :maps
  end
end
