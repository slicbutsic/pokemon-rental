class PokemonsController < ApplicationController

  def index
    if params[:query].present?
      @pokemons = Pokemon.search_pokemon(params[:query])
      @markers = @pokemons.geocoded.map do |pokemon|
        {
          lat: pokemon.latitude,
          lng: pokemon.longitude,
          infoWindow: render_to_string(partial: "popup", locals: { pokemon: pokemon }),
          image_url: helpers.asset_url('pokeball.png')
        }
      end
    else
      @pokemons = Pokemon.all

      @markers = @pokemons.geocoded.map do |pokemon|
        {
          lat: pokemon.latitude,
          lng: pokemon.longitude,
          infoWindow: render_to_string(partial: "popup", locals: { pokemon: pokemon }),
          image_url: helpers.asset_url('pokeball.png')
        }
      end
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @markers = [{
      lat: @pokemon.latitude,
      lng: @pokemon.longitude,
      infoWindow: render_to_string(partial: "popup", locals: { pokemon: @pokemon }),
      image_url: helpers.asset_url('pokeball.png')
    }]
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
