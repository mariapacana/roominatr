class Question < ActiveRecord::Base

  belongs_to :survey
  # has_many :answers

  validates_presence_of :body

  attr_accessible :body

  #IF type roommate, body = "How would you like your roommmate to answer"

end
