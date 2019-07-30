class AddAttributesToAddedLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :added_locations, :open_now, :boolean
  end
end
