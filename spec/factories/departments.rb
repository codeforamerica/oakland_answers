FactoryGirl.define do
  factory :department do
    name Faker::Lorem.word
    acronym Faker::Lorem.word
  end
end