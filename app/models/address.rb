class Address < ActiveRecord::Base
  has_many :book_addresses

  belongs_to :user
end
