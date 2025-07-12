class CreateEmployeeAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :employee_answers do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :question_option, null: true, foreign_key: true
      t.text :comment
      t.timestamps
    end

    add_index :employee_answers, [:employee_id, :survey_id, :question_id], unique: true, name: 'index_unique_answer_per_employee_survey_question'
  end
end
