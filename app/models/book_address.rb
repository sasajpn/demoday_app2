class BookAddress < ActiveRecord::Base
  belongs_to :address
  belongs_to :book
end
