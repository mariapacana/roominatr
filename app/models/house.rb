class House < ActiveRecord::Base
  belongs_to :user
  has_one :location, :as => :addressable
  accepts_nested_attributes_for :location

  attr_accessible :description,
                  :image,
                  :num_beds,
                  :rent,
                  :dog,
                  :cat,
                  :smoking,
                  :location,
                  :location_attributes
end