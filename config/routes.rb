Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "curricula#index"

  resources :curricula, only: %i[index show new create destroy]
  resources :lessons, only: %i[show] do
    post :generate, on: :collection
    post :batch_create, on: :collection
    post :batch_create_with_cards, on: :collection
  end
  resources :cards, only: %i[show] do
    patch :bookmark, on: :member
    post :attempt, on: :member
  end
  get "/bookmarks", to: "cards#bookmarks"
end
