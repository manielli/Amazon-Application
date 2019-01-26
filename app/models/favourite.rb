class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates(
    :product_id,
    uniqueness: {
      scope: :user_id,
      message: "has already been favourited"
    }
  )
end
