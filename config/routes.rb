Rails.application.routes.draw do
  post '/check_weather', to: 'home#check_weather'
  root to: 'home#index'
end
