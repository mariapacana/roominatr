class Submission < ActiveRecord::Base

  has_many :responses
  belongs_to :user
  belongs_to :survey
  accepts_nested_attributes_for :responses

  attr_accessible :survey, :user, :responses_attributes


end
