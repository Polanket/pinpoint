class AddColumnsToAddedLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :added_locations, :name, :string
    add_column :added_locations, :address, :string
    add_column :added_locations, :description, :text
    add_column :added_locations, :photo, :string
    add_column :added_locations, :latitude, :float
    add_column :added_locations, :longitude, :float
  end
end
