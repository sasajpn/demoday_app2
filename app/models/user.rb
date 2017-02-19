class User < ActiveRecord::Base
  include AssignAnimal
  include BookOption

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # override Devise::Models::Confirmable#send_on_create_confirmation_instructions
  def send_on_create_confirmation_instructions
    generate_confirmation_token! unless @raw_confirmation_token
    send_devise_notification(:confirmation_on_create_instructions, @raw_confirmation_token, {})
  end

  has_one :address
  has_many :books
  has_many :actions
  has_many :children, through: :books
  has_many :evaluatees, class_name: 'Eval', foreign_key: 'evaluatee_id'
  has_many :evaluators, class_name: 'Eval', foreign_key: 'evaluator_id'

  validates :username, :birthday, presence: true
  validates :username, :email, uniqueness: true

  before_create :set_icon

  private

  def set_icon
    self.icon = set_animal
  end
end
