require 'faraday'
require 'figaro'
require 'pry'
require_relative 'near_earth_objects_service'

class NearEarthObjects
  def self.service 
    NearEarthObjectsService.new
  end

  def self.neos_for_date(date)
    service.neos_for_date(date)
  end

  def self.largest_asteroid_diameter(date)
    service.neos_for_date(date).map do |asteroid|
      asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max { |a,b| a<=> b}
  end

  def self.total_number_of_asteroids(date)
    service.neos_for_date(date).count
  end

  def self.formatted_asteroid_data(date)
    service.neos_for_date(date).map do |astroid|
      {
        name: astroid[:name],
        diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  # def self.find_neos_by_date(date)
  #   conn = Faraday.new(
  #     url: 'https://api.nasa.gov',
  #     params: { start_date: date, api_key: ENV['nasa_api_key']}
  #   )
  #   asteroids_list_data = conn.get('/neo/rest/v1/feed')

  #   parsed_asteroids_data = JSON.parse(asteroids_list_data.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]

  #   largest_astroid_diameter = parsed_asteroids_data.map do |astroid|
  #     astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
  #   end.max { |a,b| a<=> b}

  #   total_number_of_astroids = parsed_asteroids_data.count
  #   formatted_asteroid_data = parsed_asteroids_data.map do |astroid|
  #     {
  #       name: astroid[:name],
  #       diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
  #       miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
  #     }
  #   end

  #   {
  #     astroid_list: formatted_asteroid_data,
  #     biggest_astroid: largest_astroid_diameter,
  #     total_number_of_astroids: total_number_of_astroids
  #   }
  # end
end
