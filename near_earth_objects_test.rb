require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_new_neo_serice_can_be_created
    assert_instance_of NearEarthObjectsService, NearEarthObjects.service
  end

  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.neos_for_date('2019-03-30')

    assert_equal '(2019 GD4)', results[0][:name]  
  end
end
