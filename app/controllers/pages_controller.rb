class PagesController < ApplicationController
  def home
  end

  def dashboard
    @user = current_user
    @bookings = @user.bookings

    @pokemon_price = @bookings.map { |booking| booking.pokemon.price }
  end
end
