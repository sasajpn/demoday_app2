class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :addresses
  has_many :books
  has_many :children, through: :books
  has_many :evaluatees, class_name: 'Eval', foreign_key: 'evaluatee_id'
  has_many :evaluators, class_name: 'Eval', foreign_key: 'evaluator_id'

  has_one :user_icon

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
