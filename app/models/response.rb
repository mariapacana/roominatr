class Response < ActiveRecord::Base

  belongs_to :submission, :inverse_of => :responses
  belongs_to :question
  belongs_to :answer
  attr_accessible :question_id, :answer_id, :submission_id, :question, :answer
  validates_presence_of :question, :answer, :submission

end

