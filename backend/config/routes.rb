Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "dashboard/index"
      resources :organizations, only: [:index, :show]
      resources :rockets, only: [:index, :show]
      resources :satellites, only: [:index, :show]
      resources :launches, only: [:index, :show]
      resources :news, only: [:index, :show]
      
      # Additional endpoints
      get 'launches/upcoming', to: 'launches#upcoming'
      get 'launches/past', to: 'launches#past'
      get 'news/featured', to: 'news#featured'
      get 'dashboard', to: 'dashboard#index'
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "api/v1/dashboard#index"
end
