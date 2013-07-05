class Question < ActiveRecord::Base

  belongs_to :survey
  has_many :answers

  accepts_nested_attributes_for :answers
  attr_accessible :body, :qtype, :answers_attributes
  after_create :set_body, :create_answers, :set_qtype_me

  private

  def set_body
    if qtype == "roommate"
      update_attribute("body", "How would you like your roommate to answer?")
    elsif qtype == "importance"
      update_attribute("body","How important is this to you?")
    end
  end

  def create_answers
    if qtype == "roommate"
      me_question = survey.questions.first
      me_question.answers.each do |answer|
        answers.create(text: answer.text,
                       weight: answer.weight)
      end
    elsif qtype == "importance"
      options = [["Not", 1], ["Kinda", 2], ["Very", 3]]
      options.each { |o| answers.create(text: o[0], weight: o[1])}
    end
  end

  def set_qtype_me
    update_attribute("qtype", "me") if qtype.nil?
    # if (qtype == "me")
    #   p "ME QUESTION"
    #   p self
    #   p "ME QUESTION ANSWERS"
    #   p answers
    #   roommate_question = survey.questions.find_by_qtype("roommate")
    #   p "ROOMMATE QUESTION"
    #   p roommate_question
    #   p "ROOMMATE QUESTION ANSWERS"
    #   p roommate_question.answers

    #   answers.each do |answer|
    #     roommate_question.answers.create(text: answer.text,
    #                                      weight: answer.weight)
    #   end
    #   roommate_question.save
    # end
  end

end

