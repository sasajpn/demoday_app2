class Book < ActiveRecord::Base
  has_one :parent, class_name: 'Negotiate', foreign_key: 'parent_id'
  has_one :child, class_name: 'Negotiate', foreign_key: 'child_id'
  has_one :deadline
  has_one :book_address

  belongs_to :user

  enum condition: { very_good: 3, good: 2, bad: 1, very_bad: 0 }

  scope :no_deal, -> { where(status: 0) }
  scope :deal_as_parent, -> { where(status: 1) }
  scope :deal_as_child, -> { where(status: 2) }

  after_update :create_deadline

  private

  def create_deadline
    Deadline.create(book_id: id, deadline: Time.now + 1.week) if status == 1
  end
end
