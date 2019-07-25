Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :maps
  get 'maps/:id/view', to: 'maps#add_location', as: 'view_locations'
end
