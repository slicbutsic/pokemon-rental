class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booked_date_ranges = @pokemon.bookings.pluck(:start_date, :end_date)
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    # @booking = current_user.bookings.build(booking_params)
    @booking.pokemon = @pokemon

    if @booking.save!
      redirect_to user_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    redirect_to user_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to user_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
