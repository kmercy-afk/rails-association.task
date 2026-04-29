class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true

  # Order references address_id directly
  has_many :orders, dependent: :nullify
end
