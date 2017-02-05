class CreateBookAddresses < ActiveRecord::Migration
  def change
    create_table :book_addresses do |t|
      t.references :book, index: true, foreign_key: true
      t.string :given_name
      t.string :family_name
      t.string :postal_code
      t.string :prefecture
      t.string :municipality
      t.string :street
      t.string :building

      t.timestamps null: false
    end
  end
end
