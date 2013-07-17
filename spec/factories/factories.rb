FactoryGirl.define do
  factory :category do
    name Faker::Lorem.words(1)
  end

  factory :location do  
    address Faker::Address.street_address
  end

  factory :category_score do
    me 0
    roommate 0
    importance 0
  end

  factory :answer do
  end

  factory :question do
    body Faker::Lorem.sentence(5)
  end

  factory :survey do
    title { Faker::Lorem.words(1) }
    category
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

  factory :user do
    username { Faker::Internet.user_name }
    sequence(:email) {|n| "user#{n}@mail.com"}
    birthday { Date.today }
    location
    gender { ["M", "F", "O"].sample }
    has_house { [true, false].sample }
    password "password"

    factory :user_with_category_score do
      category = create(:category)
      category_score = create(:category_score, { category: category, user: user })

      factory :user_with_submissions do 
        ignore do
          submissions_count 3
        end

        after(:create) do |user, evaluator|
          category = create(:category)
          evaluator.submissions_count.times do  
            survey = create(:survey, category: category)
            question = create(:question_with_answers, survey: survey)
            submission = create(:submission, user: user, survey: survey)
            p "WE ARE HERE"
            response = create(:response, question: question, submission: submission)
            p "WE ARE HERE TOO"

            submission.responses << response
          end
          category_score = create(:category_score, user: user, category: category)      
        end


      end

    end
  end
end
