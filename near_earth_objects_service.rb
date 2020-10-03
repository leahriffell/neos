# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjectsService
  def neos_for_date(date)
    connection = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: date, api_key: ENV['nasa_api_key']}
    )

    response = connection.get('/neo/rest/v1/feed')

    parsed = JSON.parse(response.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
  end
end