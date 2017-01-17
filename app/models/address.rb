class Address < ActiveRecord::Base
  has_many :book_addresses

  belongs_to :user

  validates :given_name, :family_name,
    presence: true, length: { maximum: 64 }

  validates :postal_code, :prefecture, :municipality, :street, :building,
    presence: true, length: { maximum: 64 }

  def address_name
    [family_name, given_name].compact.join
  end

  def address_detail
    [postal_code, prefecture, municipality, street, building].compact.join
  end

  def display_address
    [address_name, address_detail].join(' ')
  end
end
