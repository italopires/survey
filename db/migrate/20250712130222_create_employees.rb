class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :personal_email, index: { unique: true }
      t.string :corporate_email, index: { unique: true }
      t.string :phone_number
      t.string :department
      t.string :position
      t.string :role
      t.string :location
      t.string :company_tenure
      t.string :gender
      t.string :generation
      t.references :sub_team, null: true, foreign_key: true
      t.timestamps
    end
  end
end
