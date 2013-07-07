class Submission < ActiveRecord::Base

  belongs_to :user
  belongs_to :survey
  has_many :responses , :inverse_of => :submission
  accepts_nested_attributes_for :responses

  attr_accessible :survey, :user, :responses_attributes

  validates_presence_of :user, :survey

end
