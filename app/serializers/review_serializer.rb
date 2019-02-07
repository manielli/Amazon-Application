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
