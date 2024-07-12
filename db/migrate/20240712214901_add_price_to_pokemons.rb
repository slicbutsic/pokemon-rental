class AddPriceToPokemons < ActiveRecord::Migration[7.1]
  def change
    add_column :pokemons, :price, :decimal
  end
end
