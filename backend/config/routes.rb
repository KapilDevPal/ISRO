Rails.application.routes.draw do
  devise_for :users
  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end
  
  namespace :api do
    namespace :v1 do
      get 'dashboard', to: 'dashboard#index'
      
      resources :organizations, only: [:index, :show]
      resources :rockets, only: [:index, :show]
      resources :satellites, only: [:index, :show]
      resources :launches, only: [:index, :show]
      resources :news, only: [:index]
      
      # New models
      resources :space_probes, only: [:index, :show]
      resources :launch_sites, only: [:index, :show]
      resources :space_events, only: [:index, :show]
      resources :space_missions, only: [:index, :show]
      resources :astronauts, only: [:index, :show]
      resources :space_statistics, only: [:index, :show]
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "api/v1/dashboard#index"
end
