Rails.application.routes.draw do
  resources :comments
  resources :articles
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "simulate/unauthorized",        to: "errors#unauthorized"
  get "simulate/forbidden",           to: "errors#forbidden"
  get "simulate/service_unavailable", to: "errors#service_unavailable"



  # Defines the root path route ("/")
  # root "posts#index"
end
