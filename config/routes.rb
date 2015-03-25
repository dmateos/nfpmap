Rails.application.routes.draw do
  root to: 'pages#index'
  get "suburbmap", to: 'pages#suburbmap'
  get "latlong", to: "suburbs#latlong"

  resources :organisations
  resources :suburbs
end
