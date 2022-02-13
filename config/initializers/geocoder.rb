Geocoder.configure(
  timeout: 5,
  lookup: :google,
  use_https: true,
  api_key: ENV['GOOGLE_API_KEY']
)
