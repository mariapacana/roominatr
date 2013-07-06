class Response < ActiveRecord::Base
  belongs_to :submission
  belongs_to :question
  belongs_to :answer
  attr_accessible :question_id, :answer_id

  def check_answers
    questions = answers.map { |answer| answer.question }
    if questions.uniq.length == questions.length
      return true
    else
      errors << "Only 1 answer per question Plz!!!"
      return false
    end
  end
  
end

