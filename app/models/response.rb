class Response < ActiveRecord::Base
  # validates :user, :presence => true
  validates :user_id, :uniqueness => { :scope => :survey_id }
  belongs_to :user
  belongs_to :survey
  belongs_to :question
  belongs_to :answer
  # accepts_nested_attributes_for :choices, :user
  attr_accessible :user, :question_id, :answer_id
  # validate :check_answers

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

