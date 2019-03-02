class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  # To be able to get the user who have liked on a particular
  # review
  has_many :likers, through: :likes, source: :user

  has_many :likes, dependent: :destroy

  # To be able to get the users who have voted on a particular
  # review
  has_many :voters, through: :votes, source: :user
  
  has_many :votes,  dependent: :destroy

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
end
