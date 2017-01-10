class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :parent_id
      t.integer :child_id
      t.text :recommend

      t.timestamps null: false
    end
  end
end
