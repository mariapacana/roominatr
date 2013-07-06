class Response < ActiveRecord::Base

  belongs_to :submission
  belongs_to :question
  belongs_to :answer
  attr_accessible :question_id, :answer_id
  validates_presence_of :question, :answer, :submission

end

