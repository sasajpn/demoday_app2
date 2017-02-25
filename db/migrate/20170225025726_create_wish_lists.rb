class CreateWishLists < ActiveRecord::Migration
  def change
    create_table :wish_lists do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :author
      t.string :image
      t.boolean :get, default: false

      t.timestamps null: false
    end
  end
end
