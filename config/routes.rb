Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  root to: 'pages#index'
  resources :maps do
    resources :user_groups, only: [:new, :create]
  end
  get 'maps/:id/view', to: 'maps#add_location', as: 'view_locations'
end
