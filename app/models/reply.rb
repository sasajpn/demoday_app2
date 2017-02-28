class Reply < ActiveRecord::Base
  belongs_to :wish
  belongs_to :book

  validates :wish_id, uniqueness: { scope: :book_id }
end
