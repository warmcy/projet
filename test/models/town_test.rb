require 'test_helper'

class TownTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
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
