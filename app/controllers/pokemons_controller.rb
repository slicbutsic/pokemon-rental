class PokemonsController < ApplicationController

  def index
    if params[:query].present?
      @pokemons = Pokemon.search_pokemon(params[:query])
    else
      @pokemons = Pokemon.all
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    @pokemon = Pokemon.new
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @pokemon = Pokemon.find(params[:id])

    if @pokemon.update(pokemon_params)
      redirect_to pokemon_path(@pokemon)
    else
      render :edit
    end
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy!

    redirect_to pokemons_path, notice: "Pokemon deleted", status: :see_other
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :overview, :user_id, :price, photos: [])
  end

end
