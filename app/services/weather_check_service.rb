# frozen_string_literal: true

class WeatherCheckService
  attr_reader :weather, :current_temp, :low_temp, :high_temp

  # constructor
  def initialize(address_service)
    client = OpenWeather::Client.new(api_key: ENV['WEATHER_API_KEY'])
    @weather = client.one_call(
      lat: address_service.latitude,
      lon: address_service.longitude,
      exclude: ['minutely', 'hourly']
    )
  end

  # current_temp
  def current_temp
    @current_temp ||= weather["current"].temp_f
  end

  def low_temp
    @low_temp ||= weather["daily"][0].temp.min_f
  end

  def high_temp
    @high_temp ||= weather["daily"][0].temp.max_f
  end

  def extended_forecast
    forecasts = []
    weather["daily"].each do |forecast|
      forecasts << {
        date: forecast.dt.strftime("%B %d"),
        low_tem: low_temp,
        high_temp: high_temp
      }
    end
    JSON.parse(forecasts.to_json)
  end
end
