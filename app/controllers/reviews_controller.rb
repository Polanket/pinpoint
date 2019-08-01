class ReviewsController < ApplicationController

  def create
    @added_location = AddedLocation.find(params[:added_location_id])
    @review = Review.new(review_params)
    @review.added_location = @added_location
    authorize @review
    if @review.save
      redirect_to map_added_location_path(@added_location.id)
    else
      redirect_to map_added_location_path(@added_location.map_id, @added_location.id)
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
