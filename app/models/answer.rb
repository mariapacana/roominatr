class Answer < ActiveRecord::Base
  belongs_to :question
  attr_accessible :weight, :text
end
