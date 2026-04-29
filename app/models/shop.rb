class Shop < ApplicationRecord
  has_many :foods
  has_many :addresses, as: :addressable
end