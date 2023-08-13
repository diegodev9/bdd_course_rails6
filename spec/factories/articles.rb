FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 4) }
    body { Faker::Lorem.sentence(word_count: 15) }
  end
end
