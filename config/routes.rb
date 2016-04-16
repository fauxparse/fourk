Rails.application.routes.draw do
  resources :games

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
