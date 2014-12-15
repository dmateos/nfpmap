Rails.application.routes.draw do
  root to: 'pages#index'
  get "suburbmap", to: 'pages#suburbmap'

  resources :organisations
  resources :suburbs
end
