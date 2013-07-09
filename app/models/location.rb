class Location < ActiveRecord::Base
  attr_accessible :address, :lat, :long, :neighborhood, :zip
  belongs_to :user

  # before_save :get_lat_long_neighborhood

  # def format_gmaps_request
  #   "http://maps.googleapis.com/maps/api/geocode/json?&address=#{address.split(" ").join("+")}&sensor=true"
  # end

  # def get_lat_long_neighborhood
  #   conn = Faraday.new(:url => format_gmaps_request)
  #   body = JSON.parse(conn.get.body)["results"][0]
  #   if body
  #     geometry = body["geometry"]["location"]
  #     neighborhood = body["address_components"][2]["long_name"]
  #     self.lat = geometry["lat"]
  #     self.long = geometry["lng"]
  #     self.neighborhood = neighborhood
  #   end
  # end

  # def self.distance(loc1, loc2)
  #   haversine(loc1, loc2)
  # end
end