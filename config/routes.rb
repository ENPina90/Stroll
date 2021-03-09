Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/components", to: "pages#components"
  resources :users, only: [ :show ] do
    resources :starred_locations, only: [ :new, :create, :index, :destroy ]
  end

  resources :stroll_settings, only: [ :edit, :create, :update ]

  resources :locations, only: [ :new, :create, :show, :index ] 

  resources :walks do
    resources :starting_locations, only: [ :index, :show, :new, :create ]
  end
end
