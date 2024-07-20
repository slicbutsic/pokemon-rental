class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @pokemon = Pokemon.find(params[:pokemon_id])
  end

  def create
    @review = Review.new(review_params)
    @pokemon = Pokemon.find(params[:pokemon_id])
    @review.pokemon = @pokemon
    @review.user = current_user
    if @review.save!
      redirect_to pokemon_path(@pokemon)
    else
      render :new, status: :unprocessble_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to pokemon_path(@review.pokemon), status: :see_other
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to pokemon_path(@review.pokemon)
    else
      render :edit
    end
  end


  private

  def review_params
    params.require(:review).permit([:content])
  end

end
