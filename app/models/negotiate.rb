class Negotiate < ActiveRecord::Base
  belongs_to :parent, class_name: 'Book'
  belongs_to :child, class_name: 'Book'

  has_one :user, through: :child

  delegate :title, :author, :image, :condition, to: :child

  after_create :update_status_for_start
  after_destroy :update_status_for_cancel
  after_update :update_status_for_agree

  private

  def update_status_for_start
    Book.find(child).update(status: 2)
  end

  def update_status_for_cancel
    Book.find(child).update(status: 0)
  end

  def update_status_for_agree
    [parent, child].each do |object|
      Book.find(object).update(status: 3)
    end
  end
end
