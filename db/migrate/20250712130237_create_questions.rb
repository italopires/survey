class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :survey, null: false, foreign_key: true
      t.string :title, null: false, index: true
      t.integer :order
      t.timestamps
    end
  end
end
