class Address < ActiveRecord::Base
  belongs_to :user

  validates :given_name, :family_name,
    presence: true, length: { maximum: 64 }

  validates :postal_code, :prefecture, :municipality, :street,
    presence: true, length: { maximum: 64 }
end
