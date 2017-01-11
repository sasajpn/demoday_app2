class Negotiate < ActiveRecord::Base
  belongs_to :parent, class_name: 'Book'
  belongs_to :child, class_name: 'Book'

  after_create :update_status

  private

  def update_status
    Book.find(child_id).update(status: 2)
  end
end
