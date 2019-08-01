class ReviewsController < ApplicationController

  def create

    @map = Map.find(params[:map_id])
    @added_location = AddedLocation.find(params[:added_location_id])
    @review = Review.new(review_params)
    @review.added_location = @added_location
    @review.user = current_user
    @review.rating = 3
    authorize @review
    if @review.save!
      respond_to do |format|
        format.html { map_added_location_path(@added_location.map_id, @added_location.id) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { map_added_location_path(@added_location.map_id, @added_location.id) }
        format.js  # <-- idem
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
