class Book < ActiveRecord::Base
  has_many :wishes
  has_many :replies
  has_many :trades_of_wish, class_name: 'Trade', foreign_key: 'wish_book_id'
  has_many :trades_of_reply, class_name: 'Trade', foreign_key: 'reply_book_id'
  has_one :book_address
  accepts_nested_attributes_for :book_address

  belongs_to :user

  validates :title, :author, presence: true
  validates :condition, presence: { message: 'を選択してください' }
  validates :user_id, uniqueness: { scope: [:title, :author],
    message: 'その本をすでに登録しています' }

  enum condition: { very_good: 3, good: 2, bad: 1, very_bad: 0 }

  def can_get_reply?
    replies.where(status: [0, 1]).blank?
  end

  def already_reply?(book)
    replies.find_by(book_id: book)
  end
end
