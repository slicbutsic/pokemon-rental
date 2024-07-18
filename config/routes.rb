Rails.application.routes.draw do
  get 'reviews/new'
  devise_for :users
  resources :pokemons do
    resources :bookings
    resources :reviews, only: [:new, :create]
  end
  root to: "pokemons#index"
end
