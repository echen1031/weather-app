# frozen_string_literal: true

class WeatherCheckService
  attr_reader :current_weather

  # constructor
  def initialize(zipcode)
    client = OpenWeather::Client.new(api_key: ENV['WEATHER_API_KEY'])
    @current_weather = client.current_weather(zip: zipcode)
  end


  def celcius
    current_weather.main.temp_max_c
  end

  def farenheit
    current_weather.main.temp_max_f
  end
end
