Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #resources :sessions, only: [:create]
  get "validate", to: "token_validation#validate_token"
  post "login", to: "sessions#create"
  post "signup", to: "registrations#create"
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"
  get "dashboard", to: "users#dashboard"
  get "history", to: "users#get_history"
  get "up" => "rails/health#show", as: :rails_health_check
  post "add_member", to: "users#add_user"
  post "delete_member", to: "users#delete_user"  # Defines the root path route ("/"a
  # root "posts#index"
end
