class CreateUserIcons < ActiveRecord::Migration
  def change
    create_table :user_icons do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :animal_id

      t.timestamps null: false
    end
  end
end
