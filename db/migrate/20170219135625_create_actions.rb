class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.boolean :reject, default: false

      t.timestamps null: false
    end
  end
end
