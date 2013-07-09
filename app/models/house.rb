class House < ActiveRecord::Base
  belongs_to :user
  has_one :location, :as => :addressable
  accepts_nested_attributes_for :location

  validates_presence_of :rent, :location

  attr_accessible :description,
                  :image,
                  :num_beds,
                  :house_type, 
                  :num_baths, 
                  :deposit, 
                  :background_check,
                  :rent,
                  :dog,
                  :cat,
                  :smoking,
                  :location,
                  :location_attributes,
                  :avatar

  has_attached_file :avatar, :styles => {:medium => "300x300"}

end