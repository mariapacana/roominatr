class Survey < ActiveRecord::Base

  belongs_to :category
  has_many :questions   
  accepts_nested_attributes_for :questions

  validates_presence_of :title
  attr_accessible :title, :questions_attributes, :category

  after_create :create_questions

  def create_questions
    questions.create(qtype: "roommate")
    questions.create(qtype: "importance")
  end

  def me_question
    questions.select do |question|
      question.qtype == "me"
    end
  end

  def roommate_question
    questions.select do |question|
      question.qtype == "roommate"
    end
  end

  def importance_question
    questions.select do |question|
      question.qtype == "importance"
    end
  end
end

