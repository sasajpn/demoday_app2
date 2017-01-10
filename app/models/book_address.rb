class BookAddress < ActiveRecord::Base
  belongs_to :adress
  belongs_to :book
end
