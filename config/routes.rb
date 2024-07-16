Rails.application.routes.draw do
  devise_for :users
  resources :pokemons do
    resources :bookings
  end
  root to: "pokemons#index"
end
