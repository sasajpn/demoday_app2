class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :wish_book_id
      t.integer :reply_book_id
      t.boolean :finish

      t.timestamps null: false
    end
  end
end
