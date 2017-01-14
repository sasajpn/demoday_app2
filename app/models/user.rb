class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :addresses
  has_many :books
  has_many :evaluatees, class_name: 'Eval', foreign_key: 'evaluatee_id'
  has_many :evaluators, class_name: 'Eval', foreign_key: 'evaluator_id'

  has_one :user_icon
end
