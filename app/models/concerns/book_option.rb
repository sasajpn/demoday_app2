module BookOption
  extend ActiveSupport::Concern

  def mine?(object)
    self == object.user
  end

  def already_negotiate?(object)
    children.find_by(parent_id: object.id)
  end

  def until_negotiate?(object)
    children.find_by(parent_id: object.id).nil?
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
