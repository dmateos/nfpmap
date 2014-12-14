Rails.application.routes.draw do
  root to: 'pages#index'
  get 'sacommunity', to: 'pages#sacommunity'

  resources :organisations
end
