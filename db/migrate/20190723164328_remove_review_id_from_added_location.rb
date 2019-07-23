class RemoveReviewIdFromAddedLocation < ActiveRecord::Migration[5.2]
  def change
    remove_reference :added_locations, :review, index: true
  end
end
