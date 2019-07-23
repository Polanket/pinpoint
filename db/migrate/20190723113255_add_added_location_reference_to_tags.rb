class AddAddedLocationReferenceToTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :added_location, index: true
  end
end
