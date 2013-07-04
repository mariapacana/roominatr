class Category < ActiveRecord::Base

  has_many :surveys
  validates_presence_of :name

  attr_accessible :name
end
