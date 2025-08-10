Rails.application.routes.draw do
  devise_for :admin_users
  devise_for :users
  
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :organizations
    resources :rockets
    resources :launches
    resources :satellites
    resources :news, only: [:index]
  end
  
  namespace :api do
    namespace :v1 do
      get 'dashboard', to: 'dashboard#index'
      get 'dashboard/launch_success_rates', to: 'dashboard#launch_success_rates'
      get 'dashboard/top_rockets_by_payload', to: 'dashboard#top_rockets_by_payload'
      get 'dashboard/mission_cost_estimator', to: 'dashboard#mission_cost_estimator'
      get 'dashboard/human_space_missions', to: 'dashboard#human_space_missions'
      get 'dashboard/astronaut_statistics', to: 'dashboard#astronaut_statistics'
      get 'dashboard/space_mission_timeline', to: 'dashboard#space_mission_timeline'
      get 'dashboard/launch_trends', to: 'dashboard#launch_trends'
      get 'dashboard/organization_performance', to: 'dashboard#organization_performance'
      get 'dashboard/mission_progress_visualization', to: 'dashboard#mission_progress_visualization'
      get 'dashboard/mission_timeline_visualization', to: 'dashboard#mission_timeline_visualization'
      get 'dashboard/orbit_distribution', to: 'dashboard#orbit_distribution'
      get 'dashboard/mission_family_tree', to: 'dashboard#mission_family_tree'
      
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
