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
end
