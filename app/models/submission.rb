class Submission < ActiveRecord::Base

  has_many :responses
  belongs_to :user
  belongs_to :survey

  attr_accessible :survey, :user


end
