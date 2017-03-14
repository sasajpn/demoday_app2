class Reply < ActiveRecord::Base
  belongs_to :wish
  belongs_to :book

  validates :wish_id, uniqueness: { scope: :book_id }

  after_update :decide_change

  private

  def decide_change
    book.update(change: true)
    wish.book.update(change: true)
  end
end
