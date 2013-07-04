FactoryGirl.define do
  factory :category do
    name Faker::Name.name
  end

  factory :survey do
    title Faker::Lorem.words(1)
    category
  end

  factory :question do
    title Faker::Lorem.sentence(5)
    type  ["roommate", "me", "importance"].sample
    survey
  end

end
