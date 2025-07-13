class RemovePhoneNumberFromEmployee < ActiveRecord::Migration[8.0]
  def change
    remove_column :employees, :phone_number
    remove_column :employees, :position
  end
end
