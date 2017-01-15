module BookOption
  extend ActiveSupport::Concern

  def mine?(object)
    self == object.user
  end

  def already_want?(object)
    children.where(parent_id: object.id).exists?
  end

  def until_want?(object)
    children.where(parent_id: object.id).blank?
  end

  def not_mine?(object)
    self != object.user
  end

  def can_want?(object)
    until_want?(object) && not_mine?(object)
  end

  def can_cancel?(object)
    already_want?(object) && not_mine?(object)
  end
end
