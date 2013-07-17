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
    after(:create) do |s|
      create(:question, :survey => s)
    end
  end

  factory :response do
  end

  factory :submission do
    survey
    user
    # factory :submission_with_responses do
    #   ignore do
    #     responses_count 3
    #   end

    #   after(:create) do |submission, evaluator|
    #     create_list(:response, evaluator.responses_count, submission: submission)
    #   end
    # end
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
        create(:submission, :user => u)
      }
    end
  end
end

# factory :user_with_submissions do
#         ignore do
#           submissions_count 3
#         end

#         after(:create) do |user, evaluator|
#           category = create(:category)
#           evaluator.submissions_count.times do
#             survey = create(:survey, category: category)
#             question = create(:question_with_answers, survey: survey)
#             submission = create(:submission, user: user, survey: survey)
#             p "WE ARE HERE"
#             response = create(:response, question: question, submission: submission)
#             p "WE ARE HERE TOO"

#             submission.responses << response
#           end
#           category_score = create(:category_score, user: user, category: category)
#         end


#       end
