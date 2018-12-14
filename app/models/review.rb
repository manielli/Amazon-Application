class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  # product
  # product=(associate)
  # build_product(attributes = {})
  # create_product(attributes = {})
  # create_product!(attributes = {})
  # reload_product

  validates(
    :rating, 
    presence: true,
    numericality: {
      greater_than_or_equal_to: 1,
      lesser_than_or_equal_to: 6,
      }
    )

    private
    def review_params
      params.require(:review).permit(:body, :rating)
    end

end
