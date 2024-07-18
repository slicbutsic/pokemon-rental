Rails.application.routes.draw do
  devise_for :users
  resources :pokemons do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:destroy, :edit, :update]
  root to: "pokemons#index"
  get "/users", to: "pages#dashboard", as: :user
end
