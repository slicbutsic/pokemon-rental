class RemovePhotoFromPokemon < ActiveRecord::Migration[7.1]
  def change
    remove_column :pokemons, :photo_url, :string
    remove_column :pokemons, :photo2_url, :string
  end
end
