class Customer < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  has_many :orders, dependent: :destroy
end
