class Survey < ActiveRecord::Base

  belongs_to :category
  has_many :questions   
  accepts_nested_attributes_for :questions

  validates_presence_of :title
  attr_accessible :title, :questions_attributes

  before_create :create_questions


  def create_questions
    #Create questions to accompany first question.

  end

end

