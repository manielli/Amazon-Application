class ProductSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :description,
    :price,
    :favourites_count,
    :tag_names,
    :created_at,
    :updated_at
  )

  belongs_to(:user, key: :author)
  has_many(:reviews)

  class ReviewSerializer < ActiveModel::Serializer
    attributes(
      :id,
      :body,
      :rating,
      :created_at,
      :updated_at
    )
    belongs_to(
      :user,
      key: :author
    )
  end

  def favourites_count
    object.favourites.count
  end
end
