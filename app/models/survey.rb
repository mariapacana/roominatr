class Survey < ActiveRecord::Base

  belongs_to :category
  has_many :questions   

  validates_presence_of :title

  attr_accessible :title

  after_create :create_questions

  def create_questions
    
  end

end
