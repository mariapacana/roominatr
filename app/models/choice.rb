class Choice < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  belongs_to :response
end