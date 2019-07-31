class AddTypesToAddedLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :added_locations, :types, :string
  end
end
