class User < ActiveRecord::Base
  include AssignAnimal
  include BookOption

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :addresses
  has_many :books
  has_many :children, through: :books
  has_many :evaluatees, class_name: 'Eval', foreign_key: 'evaluatee_id'
  has_many :evaluators, class_name: 'Eval', foreign_key: 'evaluator_id'

  after_create do
    update(icon: set_animal)
  end
end
