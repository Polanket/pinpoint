class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.text :description
      t.string :photo
      t.float :lng
      t.float :lat

      t.timestamps
    end
  end
end
