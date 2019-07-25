Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  resources :maps
  get 'maps/:id/results', to: 'maps#results', as: 'search_results'
  post 'maps/:id/:marker_id', to: 'maps#save_marker', as: 'save_marker'
end
