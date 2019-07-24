class RemoveTagsFromAddedLocation < ActiveRecord::Migration[5.2]
  def change
    remove_reference :added_locations, :tag, index: true
  end
end
