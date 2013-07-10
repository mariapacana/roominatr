class Location < ActiveRecord::Base
  attr_accessible :lat, 
                  :long, 
                  :address,
                  :addressable_type,
                  :neighborhood,
                  :city,
                  :state,
                  :zip
                  
  belongs_to :addressable, :polymorphic => true

  before_save :get_more_info

  def get_more_info
    if addressable_type == "User"
      get_user_info
    else
      get_lat_long_neighborhood
    end
  end

  def format_gmaps_request_user
    "http://maps.googleapis.com/maps/api/geocode/json?&address=#{zip}&sensor=true"
  end

  def formatted_address
    URI::encode([address,city,state].join(" "))
  end

  def format_gmaps_request_house
    "http://maps.googleapis.com/maps/api/geocode/json?&address=#{formatted_address}&sensor=true"
  end

  def get_user_info
    conn = Faraday.new(:url => format_gmaps_request_user)
    body = JSON.parse(conn.get.body)["results"][0]

    if body
      geometry = body["geometry"]["location"]
      self.city = body["address_components"][2]["long_name"]
      self.state = body["address_components"][3]["long_name"]
      self.country = body["address_components"][4]["long_name"]
      self.lat = geometry["lat"]
      self.long = geometry["lng"]
    end
  end

  def get_lat_long_neighborhood
    conn = Faraday.new(:url => format_gmaps_request_house)
    body = JSON.parse(conn.get.body)["results"][0]
    if body
      geometry = body["geometry"]["location"]
      neighborhood = body["address_components"][2]["long_name"]
      self.lat = geometry["lat"]
      self.long = geometry["lng"]
      self.neighborhood = neighborhood
    end
  end
end