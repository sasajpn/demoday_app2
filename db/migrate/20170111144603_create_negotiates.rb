class CreateNegotiates < ActiveRecord::Migration
  def change
    create_table :negotiates do |t|
      t.integer :parent_id
      t.integer :child_id
      t.text :recommend
      t.boolean :agree, default: false

      t.timestamps null: false
    end
  end
end
