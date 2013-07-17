FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.words(1) }
  end

  factory :location do
    address { Faker::Address.street_address }
  end

  factory :category_score do
    me 0
    roommate 0
    importance 0
  end

  factory :answer do
    text {Faker::Lorem.sentence(1)}
    weight { [-1, 0, 1].sample }
    question
  end

  factory :question do
    body { Faker::Lorem.sentence(5) }
  end

  factory :survey do
    title { Faker::Lorem.words(1) }
    category
    before(:create) do |s|
      create(:question, :survey => s, qtype: "me")
      3.times { s.questions.where("qtype=?","me").first.answers << create(:answer, question: s.questions.where("qtype=?","me").first) }
      answers = s.questions.where("qtype=?","me").first.answers
      roommate_question = s.questions.where("qtype=?","roommate").first
      answers.each do |answer|
        roommate_question.answers << create(:answer, question: roommate_question, text: answer.text, weight: answer.weight)
      end
    end
  end

  factory :response do
  end

  factory :submission do
    survey
    user
  end

  factory :submission_with_responses, :parent => :submission do
    after(:create) do |s|
      s.survey.questions.each do |q|
        create(:response, :question => q, :submission => s, :answer => create(:answer, :question => q))
      end
    end
  end

  factory :user do
    username { Faker::Internet.user_name }
    sequence(:email) {|n| "user#{n}@mail.com"}
    birthday { Date.today }
    location
    gender { ["M", "F", "O"].sample }
    has_house { [true, false].sample }
    password "password"
  end

  factory :user_with_submissions, :parent => :user do
    after(:create) do |u|
      3.times {
        create(:submission_with_responses, :user => u)
      }
    end
  end
end

