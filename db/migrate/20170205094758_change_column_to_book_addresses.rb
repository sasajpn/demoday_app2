class ChangeColumnToBookAddresses < ActiveRecord::Migration
  def change
    add_column :book_addresses, :given_name, :string
    add_column :book_addresses, :family_name, :string
    add_column :book_addresses, :postal_code, :string
    add_column :book_addresses, :prefecture, :string
    add_column :book_addresses, :municipality, :string
    add_column :book_addresses, :street, :string
    add_column :book_addresses, :building, :string
    remove_foreign_key :book_addresses, :addresses
    remove_index :book_addresses, :address_id
    remove_reference :book_addresses, :address
  end
end
