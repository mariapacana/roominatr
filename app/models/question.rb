class Question < ActiveRecord::Base

  belongs_to :survey
  # has_many :answers

  # validates_presence_of :body

  attr_accessible :body, :qtype
  accepts_nested_attributes_for :answers
  #IF type roommate, body = "How would you like your roommmate to answer"

  after_create :set_body

    #If type roommate, body = "how woudl you like rmm to answer"
  private

  def set_body
    if qtype == "roommate"
      body = "How would you like your roommate to answer?"
    else
      body = "How important is this to you?"
    end
  end

end

