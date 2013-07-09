class House < ActiveRecord::Base
  has_one :location, :as => :addressable
end