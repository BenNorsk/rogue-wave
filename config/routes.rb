Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"

  get "/playground", to: "pages#playground"

  # routes created following the spec laid out in https://shorturl.at/chpV6
  resources :boats, only: %i[index show] do
    resources :bookings, only: %i[new create]
  end

  get "/search/:query", to: "boats#search"

  resources :bookings, only: %i[show]

  namespace :user do
    resources :boats
    resources :bookings, only: %i[index destroy]
  end
end
