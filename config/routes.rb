Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :pokemons, except: [:index]
  get 'pokemons', to: 'pokemons#index', as: 'pokemons_index'
end
