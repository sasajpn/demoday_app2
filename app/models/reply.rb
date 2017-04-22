class Reply < ActiveRecord::Base
  belongs_to :wish
  belongs_to :book

  validates :wish_id, uniqueness: { scope: :book_id }

  after_update :decide_change, :create_trade

  private

  def decide_change
    if status == 2
      book.update(change: true)
      wish.book.update(change: true)
    end
  end

  def create_trade
    if status == 2
      Trade.create(book_id: wish.book.id, change_id: book.id)
      Trade.create(book_id: book.id, change_id: wish.book.id)
    end
  end
end
