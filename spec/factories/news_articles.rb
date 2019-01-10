FactoryBot.define do
  factory :news_article do
    association(:user)

    title {Faker::Space.launch_vehicule}
    description {Faker::Lorem.paragraph(1, true, 4)}
  end
end
