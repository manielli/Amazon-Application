FactoryBot.define do
  factory :vote do
    status { false }
    user { nil }
    review { nil }
  end
end
