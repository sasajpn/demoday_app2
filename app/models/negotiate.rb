class Negotiate < ActiveRecord::Base
  belongs_to :parent, class_name: 'Book'
  belongs_to :child, class_name: 'Book'

  delegate :user, :status, to: :parent, prefix: :parent
  delegate :user, :status, to: :child, prefix: :child
  delegate :title, :author, :image, :condition, to: :child

  validates :child_id, presence: true
  validates :recommend, length: { maximum: 140 }

  after_create :update_status_for_start
  after_destroy :update_status_for_cancel
  after_update :update_status_for_agree
  after_update :destroy_not_agree

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

  def destroy_not_agree
    if agree == true
      negotiates = Negotiate.where(parent_id: parent).where.not(agree: true)
      negotiates.each do |negotiate|
        Book.find(id: child_id).update(status: 0)
        negotiate.destroy
      end
    end
  end
end
