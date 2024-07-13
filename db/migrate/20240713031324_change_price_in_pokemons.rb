class ChangePriceInPokemons < ActiveRecord::Migration[7.1]
  def change
    change_column :pokemons, :price, :integer, null: false
  end
end
