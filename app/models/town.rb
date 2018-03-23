require 'forecast_io'
ForecastIO.configure do |configuration|
  configuration.api_key = '9dd5cfea95cc580c3d6d1bd573594d73'
end

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
  
  public
  def forecast
    return forecast = ForecastIO.forecast(self.lat, self.long, params: { units: 'si' })
  end
end
