class CreateEmployeeAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :employee_answers do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_option, null: false, foreign_key: true
      t.text :comment
      t.timestamps
    end
  end
end
