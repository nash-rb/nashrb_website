Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :events

  get "/sign-up" => "users#new", as: :sign_up
  get "/sign-in" => "sessions#new", as: :sign_in
  get "/sign-out" => "sessions#destroy", as: :sign_out

  root to: "events#index"
end
