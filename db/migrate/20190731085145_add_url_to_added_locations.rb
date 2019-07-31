class AddUrlToAddedLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :added_locations, :url, :string
  end
end
