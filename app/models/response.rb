class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :choices
  accepts_nested_attributes_for :choices

end
