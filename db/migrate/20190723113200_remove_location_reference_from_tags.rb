class RemoveLocationReferenceFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tags, :location, index: true
  end
end
