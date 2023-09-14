Rails.application.routes.draw do
  get 'dashboards/index', as: :dashboards
  delete '/logout', to: 'logins#destroy', as: 'logout'

  resources :logins, only: %i[new create]
  resources :registrations, only: %i[new create]
  resources :posts, only: [:new, :create, :index, :edit, :update, :show]

  root 'dashboards#index'
end
