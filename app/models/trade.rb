class Trade < ActiveRecord::Base
  belongs_to :wish_book, class_name: 'Book'
  belongs_to :reply_book, class_name: 'Book'
end
