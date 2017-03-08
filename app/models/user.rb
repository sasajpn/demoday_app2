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
  has_many :wish_lists
  has_many :wishes
  has_many :evaluatees, class_name: 'Eval', foreign_key: 'evaluatee_id'
  has_many :evaluators, class_name: 'Eval', foreign_key: 'evaluator_id'

  validates :username, :birthday, presence: true
  validates :username, :email, uniqueness: true

  before_create :create_icon

  def already_wish(item)
    wishes.find_by(book_id: item)
  end

  def already_reject_wish(item)
    if wish = already_wish(item)
      wish.reject == true
    end
  end

  def set_icon
    Animal.find(self.icon).name
  end

  private

  def create_icon
    self.icon = set_animal
  end
end
