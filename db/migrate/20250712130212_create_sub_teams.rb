class CreateSubTeams < ActiveRecord::Migration[8.0]
  def change
    create_table :sub_teams do |t|
      t.string :name, null: false, index: true
      t.references :team, null: false, foreign_key: true
      t.timestamps
    end
  end
end
