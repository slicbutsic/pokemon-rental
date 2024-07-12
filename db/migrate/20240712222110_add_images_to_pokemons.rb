class AddImagesToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :photo2_url, :string
  end
end
