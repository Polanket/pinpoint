class RemoveLocationReferenceFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reviews, :location, index: true
  end
end
