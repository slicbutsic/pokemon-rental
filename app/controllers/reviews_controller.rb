class ReviewsController < ApplicationController
  def new
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review = Review.new
  end

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review = Review.new(review_params)
    @review.pokemon = @pokemon
    @review.user = current_user
    @review.save
    redirect_to pokemon_path(@pokemon)
  end

  private

  def review_params
    params.require(:review).permit([:content])
  end
end
