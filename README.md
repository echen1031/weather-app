# Weather App

## About

Weather app will take any US address input and return the current temperature as well as the low, high, and extended forecasts

## Setting up

* `bundle install` to get all required gems
* `bundle exec rake db:setup` to setup the database
* You will need to obtain api key from [OpenWeatherMap] and place it in 'config/local_env.yml' as `WEATHER_API_KEY`
* You will need to obtain api key from [GoogleCloudConsole] and place it in 'config/local_env.yml' as `GOOGLE_API_KEY`

## Running

`bundle exec rails s`

This will run the Rails server on <http://localhost:3000>

`rails dev:cache`

This command will enable caching for faster performance in development mode. Repeat command to disable caching.

[OpenWeatherMap]: https://home.openweathermap.org/
[GoogleCloudConsole]: https://console.cloud.google.com/
