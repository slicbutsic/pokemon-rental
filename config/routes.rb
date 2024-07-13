Rails.application.routes.draw do
  devise_for :users
  resources :pokemons do
    resources :bookings, only:[:new, :create, :destroy, :update]
  end
  root to: "pokemons#index"
end
