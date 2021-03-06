module LocationsHelper

  def to_rad
    self * Math::PI / 180
  end

  # http://www.movable-type.co.uk/scripts/latlong.html
  # loc1 and loc2 are arrays of [latitude, longitude]
  def haversine(loc1, loc2)
   lat1, lon1 = loc1
   lat2, lon2 = loc2
   dLat = (lat2-lat1).to_rad
   dLon = (lon2-lon1).to_rad
   a = Math.sin(dLat/2) * Math.sin(dLat/2) +
       Math.cos(lat1.to_rad) * Math.cos(lat2.to_rad) *
       Math.sin(dLon/2) * Math.sin(dLon/2)
   c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
   d = 6371 * c # Multiply by 6371 to get Kilometers
  end

end