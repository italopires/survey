class ChangeGenderToInteger < ActiveRecord::Migration[8.0]
  def change
    change_column :employees, :gender, :integer, using: 'gender::integer'
  end
end
