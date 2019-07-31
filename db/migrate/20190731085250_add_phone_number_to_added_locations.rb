class AddPhoneNumberToAddedLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :added_locations, :phone_number, :string
  end
end
