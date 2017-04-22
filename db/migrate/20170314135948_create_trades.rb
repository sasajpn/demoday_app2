class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.references :book, index: true, foreign_key: true
      t.integer :change_id
      t.boolean :finish, default: false

      t.timestamps null: false
    end
  end
end
