class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = Booking.new(booking_params)
    @booking.pokemon = @pokemon

    if @booking.save
      redirect_to pokemon_booking_path(@pokemon, @booking), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end


  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to pokemons_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
