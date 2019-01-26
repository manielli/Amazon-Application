class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :product

  validates(
    :tag_id,
    uniqueness: {
      scope: :product_id,
      message: "Has already been tagged with this tagging!"
    }
  )
end
