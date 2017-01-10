class CreateEvals < ActiveRecord::Migration
  def change
    create_table :evals do |t|
      t.integer :evaluatee_id
      t.integer :evaluator_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
