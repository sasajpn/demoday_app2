class CreateBookAddresses < ActiveRecord::Migration
  def change
    create_table :book_addresses do |t|
      t.references :book, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
