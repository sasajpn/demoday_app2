class Reply < ActiveRecord::Base
  belongs_to :wish
  belongs_to :book
end
