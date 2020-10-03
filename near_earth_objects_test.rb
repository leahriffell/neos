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
  
  def test_it_can_get_total_asteroids_for_a_date
    assert_equal 8, NearEarthObjects.total_number_of_asteroids('2020-10-03')
  end 

  def test_it_can_get_largest_asteroid
    assert_equal 1054, NearEarthObjects.largest_asteroid_diameter('2020-10-03')
  end
end
