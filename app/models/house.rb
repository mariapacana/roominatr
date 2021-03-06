class House < ActiveRecord::Base
  belongs_to :user
  has_one :location, :as => :addressable
  accepts_nested_attributes_for :location

  validates_presence_of :rent, :location
  validates_associated :location
  validates_numericality_of :rent, :numericality => { :greater_than => 0 }

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
                  :avatar,
                  :user

  has_attached_file :avatar, :styles => {:medium => "300x300"}, :default_url => '/default_home'

end