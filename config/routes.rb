Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  resources :users, only: :show
  root to: 'pages#index'
  resources :maps do
    resources :added_locations, only: [:show, :edit, :update]
    resources :user_groups, only: [:new, :create]
  end
  resource :map_queries
  get 'maps/:id/results', to: 'maps#results', as: 'search_results'
  post 'maps/:id/:marker_id', to: 'added_locations#create', as: 'save_marker'
end
