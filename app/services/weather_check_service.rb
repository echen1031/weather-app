# frozen_string_literal: true

class WeatherCheckService
  attr_reader :weather_object, :current_temp, :low_temp, :high_temp, :type, :api_call

  # constructor
  def initialize(address_service, type='f')
    client = OpenWeather::Client.new(api_key: ENV['WEATHER_API_KEY'])
    # returns open-weather ruby client object
    @type = type
    # caching the results for 30 minutes
    @weather_object = Rails.cache.fetch(address_service.postal_code, expires_in: 30.minutes) do
      @api_call = 'false'
      client.one_call(
        lat: address_service.latitude,
        lon: address_service.longitude,
        exclude: ['minutely', 'hourly']
      )
    end
  end

  def cached?
    api_call.nil?
  end

  # current_temp
  def current_temp
    @current_temp ||= weather_object["current"].send("temp_#{type}").to_s + "#{type.capitalize}"
  end

  def low_temp
    @low_temp ||= weather_object["daily"][0].temp.send("min_#{type}").to_s + "#{type.capitalize}"
  end

  def high_temp
    @high_temp ||= weather_object["daily"][0].temp.send("max_#{type}").to_s + "#{type.capitalize}"
  end

  def extended_forecast
    forecasts = []
    weather_object["daily"].each do |forecast|
      forecasts << {
        date: forecast.dt.strftime("%B %d"),
        low_temp: low_temp,
        high_temp: high_temp
      }
    end
    JSON.parse(forecasts.to_json)
  end
end
