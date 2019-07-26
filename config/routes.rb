Rails.application.routes.draw do
  devise_for :users
  resources :users, only: :show
  root to: 'pages#index'
  resources :maps do
    resources :user_groups, only: [:new, :create]
  end
  get 'maps/:id/results', to: 'maps#results', as: 'search_results'
  post 'maps/:id/:marker_id', to: 'maps#save_marker', as: 'save_marker'
end
