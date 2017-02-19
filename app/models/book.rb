class Book < ActiveRecord::Base
  has_many :replies
  has_many :parents, class_name: 'Negotiate', foreign_key: 'parent_id'
  has_one :child, class_name: 'Negotiate', foreign_key: 'child_id'
  has_one :deadline
  has_one :book_address
  accepts_nested_attributes_for :book_address

  belongs_to :user

  validates :title, :author, presence: true

  validates :condition, presence: { message: 'を選択してください' }

  validates :user_id, uniqueness: { scope: [:title, :author],
    message: 'その本をすでに登録しています' }

  enum condition: { very_good: 3, good: 2, bad: 1, very_bad: 0 }

  after_update :create_deadline

  def set_negotiate
    parents.find_by(agree: true) || child
  end

  def notice_message
    case status
    when 1
      '本を取引に出しました。'
    end
  end

  def cancel_negotiate
    parents.each do |parent|
      Book.find(parent.child).update(status: 0)
    end
  end

  def destroy_all_negotiate
    parents.destroy_all
  end

  private

  def create_deadline
    Deadline.create(book_id: id, deadline: Time.now + 1.week) if status == 1
  end
end
