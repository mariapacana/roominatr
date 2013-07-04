class Survey < ActiveRecord::Base

  belongs_to :category
  has_many :questions   
  accepts_nested_attributes_for :questions

  validates_presence_of :title
  attr_accessible :title, :questions_attributes

  after_create :create_questions

  def create_questions
    #Create questions to accompany first question.
    p "*************************************************"
    p "FIRST QUESTION OF THE SURVEY!!!!!"
    p questions.first

    questions.first.update_attribute('qtype', "me")

    questions.create(qtype: "roommate")
    questions.create(qtype: "importance")

    p "ALL AMAZING QUESTIONS!!!!"
    p questions

  end

end

