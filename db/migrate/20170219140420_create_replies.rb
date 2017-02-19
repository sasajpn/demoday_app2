class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :action, index: true, foreign_key: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
