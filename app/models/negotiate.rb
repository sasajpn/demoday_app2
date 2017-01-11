class Negotiate < ActiveRecord::Base
  belongs_to :parent, class_name: 'Book'
  belongs_to :child, class_name: 'Book'
end
