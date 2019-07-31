class RemoveOpenNowFromAddedLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :added_locations, :open_now
  end
end
