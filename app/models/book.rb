class Book < ActiveRecord::Base
  has_one :parent, class_name: 'Deal', foreign_key: 'parent_id'
  has_one :child, class_name: 'Deal', foreign_key: 'child_id'
  has_one :deadline
  has_one :book_address

  belongs_to :user

  scope :no_deal, -> { where(status: 0) }
  scope :deal_as_parent, -> { where(status: 1) }
  scope :deal_as_child, -> { where(status: 2) }
end
