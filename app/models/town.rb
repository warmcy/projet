class Town < ActiveRecord::Base
  before_validation :geocode
  validates :name, :lat, :long, presence: true
  
  private
  def geocode
    towns = Nominatim.search.city(self.name).limit(1)
    if towns && towns.first
      current_town = towns.first
      self.lat = current_town.lat
      self.long = current_town.lon
    end
  end
  darksky = Darksky::API.new('9dd5cfea95cc580c3d6d1bd573594d73')
  # Returns a forecast for the next hour at a given location.
  forecast = darksky.forecast('42.7243','-73.6927')

  # Returns a brief forecast for the next hour at a given location.
  brief_forecast = darksky.brief_forecast('42.7243','-73.6927')

  # Returns forecasts for a collection of arbitrary points.
  precipitation = darksky.precipitation(['42.7','-73.6',1325607100,'42.0','-73.0',1325607791])

  # Returns a list of interesting storms happening right now.
  interesting_storms = darksky.interesting
  
end
