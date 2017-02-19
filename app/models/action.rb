class Action < ActiveRecord::Base
  has_many :reply
  belongs_to :user
  belongs_to :book
end
