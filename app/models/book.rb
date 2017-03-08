class Book < ActiveRecord::Base
  has_many :wishes
  has_many :replies
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
end
