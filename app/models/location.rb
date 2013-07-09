class Location < ActiveRecord::Base
  attr_accessible :zip, :lat, :long, :neighborhood
  belongs_to :addressable, :polymorphic => true

  # before_save :get_lat_long_zip

  def format_gmaps_request_zip
    "http://maps.googleapis.com/maps/api/geocode/json?&address=#{zip}&sensor=true"
  end

  def get_lat_long_zip
    conn = Faraday.new(:url => format_gmaps_request_zip)
    body = JSON.parse(conn.get.body)["results"][0]
    body
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

  def self.distance(loc1, loc2)
    haversine(loc1, loc2)
  end
end