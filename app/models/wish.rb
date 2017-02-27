class Wish < ActiveRecord::Base
  has_many :replies
  belongs_to :user
  belongs_to :book
end
