Rails.application.routes.draw do
  get 'reviews/new'
  devise_for :users
  resources :pokemons do
    resources :bookings, only: [:new, :create]
    resources :reviews, only: [:new, :create]
  end
  resources :bookings, only: [:destroy, :edit, :update]
  resources :reviews, only: [:update, :edit, :destroy]
  root to: "pokemons#index"
  get "/users", to: "pages#dashboard", as: :user
  # destroy "/reviews/:id", to: "reviews/destroy", as: :destroy
end
