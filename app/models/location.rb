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

    if conn.get.body
      body = JSON.parse(conn.get.body)["results"][0]
    end

    if body
      geometry = body["geometry"]["location"] if body["geometry"]["location"]
      self.lat = geometry["lat"] if geometry["lat"]
      self.long = geometry["lng"] if geometry["lng"]

      body["address_components"].each do |addy|
        self.country = addy["long_name"] if addy["types"].include?("country") 
        self.state = addy["long_name"] if addy["types"].include?("administrative_area_level_1") 
        self.city = addy["long_name"] if addy["types"].include?("locality") 
      end  
    end
  end

  def get_lat_long_neighborhood
    conn = Faraday.new(:url => format_gmaps_request_house)
    if conn.get.body
      body = JSON.parse(conn.get.body)["results"][0]
    end

    if body
      geometry = body["geometry"]["location"]
      self.lat = geometry["lat"]
      self.long = geometry["lng"]

      body["address_components"].each do |addy|
        self.country = addy["long_name"] if addy["types"].include?("country") 
        self.state = addy["long_name"] if addy["types"].include?("administrative_area_level_1") 
        self.neighborhood = addy["long_name"] if addy["types"].include?("neighborhood")
        self.city = addy["long_name"] if addy["types"].include?("locality") 
      end 
    end
  end
end