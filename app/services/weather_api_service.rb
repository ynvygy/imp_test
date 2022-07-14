class WeatherApiService < GetApiService
  LINK_BASE = 'https://api.weatherapi.com/v1/forecast.json'.freeze
  API_KEY = '55b7fdf17805493199a143223212409'.freeze
  WARM = { min: 15, max: 25 }.freeze

  def initialize(code)
    @link = build_link(code)

    @response_body = JSON.parse make_api_call.body
  end

  def check_weather
    # this could also be done by checking the status
    return @response_body['error']['message'] if @response_body['error']
    return 'The code does not belong to the UK' unless uk_code?

    type_of_temperature(response_temperature)
  end

  private

  def type_of_temperature(temperature)
    # a case system could also work
    if temperature.between?(WARM[:min], WARM[:max])
      'WARM'
    elsif temperature > WARM[:max]
      'HOT'
    else
      'COLD'
    end
  end

  def response_temperature
    @response_body['forecast']['forecastday'][0]['day']['avgtemp_c']
  end

  def uk_code?
    @response_body['location']['country'] == 'UK'
  end

  def build_link(code)
    "#{LINK_BASE}?key=#{API_KEY}&q=#{code}&days=0"
  end
end
