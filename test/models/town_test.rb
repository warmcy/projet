require 'test_helper'

class TownTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "darksky init" do
    darksky = Darksky::API.new('9dd5cfea95cc580c3d6d1bd573594d73')
    # Returns a forecast for the next hour at a given location.
    darksky.forecast('42.7243','-73.6927')

    # Returns a brief forecast for the next hour at a given location.
    darksky.brief_forecast('42.7243','-73.6927')

    # Returns forecasts for a collection of arbitrary points.
    darksky.precipitation(['42.7','-73.6',1325607100,'42.0','-73.0',1325607791])

    # Returns a list of interesting storms happening right now.
    darksky.interesting
    assert darksky.valid?
  end
  
  test "town validation does geocoding" do
    belfort = Town.new
    belfort.name = 'belfort'
    assert belfort.valid?
    assert_equal(47.6379599, belfort.lat)
    assert_equal(6.8628942, belfort.long)
  end
  
  test "town does not exist" do
    unknown = Town.new
    unknown.name = 'MyString'
    assert !unknown.valid?
  end
end
