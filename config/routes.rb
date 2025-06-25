# config/routes.rb
Rails.application.routes.draw do
  post "/login", to: "auth#login"
  post "/signup", to: "registrations#create"
  get "/test", to: "auth#test"


  resources :posts
  resources :feedbacks
  resources :users, only: [ :index, :update ]
  get "/audits", to: "audits#index"
  post "/impersonate/:id", to: "impersonations#create"
  post "/stop_impersonating", to: "impersonations#destroy"
end
