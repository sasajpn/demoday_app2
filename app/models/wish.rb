class Wish < ActiveRecord::Base
  has_many :replies
  belongs_to :user
  belongs_to :book

  def can_reply?
    replies.count == replies.where(status: 1).count
  end
end
