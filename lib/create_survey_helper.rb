module SurveyHelper

  def create_survey(title, category, question_body, answers)
    survey = Survey.create(title: title)
    survey.questions << make_questions(question_body, answers)
  end

  def make_questions(body)
    #need to incorporate answers
    question1 = Question.create(body: body, type: "me")
    question2 = Question.create(type: "roommate")
    question3 = Question.create(type: "importance")
    [question1, question2, question3]
  end
  
end
