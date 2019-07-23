class CreateAddedLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :added_locations do |t|
      t.references :location, foreign_key: true
      t.references :map, foreign_key: true
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
