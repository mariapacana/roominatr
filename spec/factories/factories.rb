FactoryGirl.define do
  factory :category do
    name Faker::Name.name
  end

  factory :survey do
    title Faker::Lorem.words(1)
    category

    factory :survey_with_questions do
      ignore do
        questions_count 1
      end

      before(:create) do |survey, evaluator|
        create_list(:question_with_answers, evaluator.questions_count, survey: survey, qtype: nil) 
      end
    end
  end

  factory :question do
    body Faker::Lorem.sentence(5)
    qtype  ["roommate", "me", "importance"].sample
    survey

    factory :question_with_answers do
      ignore do
        answers_count 3
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, question: question ) 
      end
    end
  end

  factory :answer do
    text Faker::Lorem.words(5)
    weight [1,0,-1].sample
  end

end
