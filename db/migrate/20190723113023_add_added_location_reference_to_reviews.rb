class AddAddedLocationReferenceToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :added_location, index: true
  end
end
