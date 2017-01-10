class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.references :prefecture, index: true, foreign_key: true
      t.string :postal_code
      t.string :municipality
      t.string :street

      t.timestamps null: false
    end
  end
end
