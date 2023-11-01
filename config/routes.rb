Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :users, only: [:show]
  resources :events, only: [:index, :new, :create, :show]
  resources :user_events, only: [:create]
  delete "user_events", to: "user_events#destroy"
  root "events#index"
end
