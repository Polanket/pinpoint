class AddReferencesToAddedLocations < ActiveRecord::Migration[5.2]
  def change
    add_reference :added_locations, :tag, index: true

    remove_reference :added_locations, :location, index: true
  end
end
