class AddNameToUserGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :user_groups, :name, :string
  end
end
