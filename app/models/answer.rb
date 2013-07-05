class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :responses
  attr_accessible :weight, :text
end
