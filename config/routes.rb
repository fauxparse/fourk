Rails.application.routes.draw do
  resources :games

  get "/auth/google/callback" => "sessions#create"
  get "/logout" => "sessions#destroy", as: :logout
  get "/login" => "sessions#new", as: :login

  root to: "games#index"

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
