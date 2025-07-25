class CreateDepartments < ActiveRecord::Migration[8.0]
  def change
    create_table :departments do |t|
      t.string :name, null: false, index: true
      t.references :division, null: false, foreign_key: true
      t.timestamps
    end
  end
end
