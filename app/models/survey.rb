class Survey < ActiveRecord::Base

  belongs_to :category
  has_many :questions   

end
