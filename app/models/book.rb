class Book < ActiveRecord::Base
  has_one :parent, class_name: 'Deal', foreign_key: 'parent_id'
  has_one :child, class_name: 'Deal', foreigh_key: 'child_id'
  has_one :deadline
  has_one :book_address
  belongs_to :user
end
