class Location < ActiveRecord::Base
  attr_accessible :address, :lat, :long, :neighborhood
  belongs_to :user

  before_save :get_lat_long_neighborhood

  def format_gmaps_request
    "http://maps.googleapis.com/maps/api/geocode/json?&address=#{address.split(" ").join("+")}&sensor=true"
  end

  def get_lat_long_neighborhood
    conn = Faraday.new(:url => format_gmaps_request)
    body = JSON.parse(conn.get.body)["results"][0]
    if body
      geometry = body["geometry"]["location"]
      neighborhood = body["address_components"][2]["long_name"]
      self.lat = geometry["lat"]
      self.long = geometry["lng"]
      self.neighborhood = neighborhood
    end
  end

  # class Numeric
  #   def to_rad
  #     self * Math::PI / 180
  #   end
  # end
 
  # # http://www.movable-type.co.uk/scripts/latlong.html
  # # loc1 and loc2 are arrays of [latitude, longitude]
  # def distance loc1, loc2
  #    lat1, lon1 = loc1
  #    lat2, lon2 = loc2
  #    dLat = (lat2-lat1).to_rad;
  #    dLon = (lon2-lon1).to_rad;
  #    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
  #        Math.cos(lat1.to_rad) * Math.cos(lat2.to_rad) *
  #        Math.sin(dLon/2) * Math.sin(dLon/2);
  #    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  #    d = 6371 * c; # Multiply by 6371 to get Kilometers
  # end
  # end
end