Rails.application.routes.draw do
  root to: 'pages#index'
  get "suburbmap", to: 'pages#suburbmap'
  get "orgssuburbmap", to: 'pages#orgssuburbmap'

  resources :organisations
  resources :suburbs
end
