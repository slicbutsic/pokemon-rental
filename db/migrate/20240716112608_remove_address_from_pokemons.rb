class RemoveAddressFromPokemons < ActiveRecord::Migration[7.1]
  def change
    remove_column :pokemons, :address, :string
  end
end
