# frozen_string_literal: true

require 'rails_helper'

describe WeatherCheckService, type: :model do
  let!(:address_double) { double }
  let!(:client_double) { double }
  let!(:weather_double) { double }
  let!(:main_double) { double }

  describe '#celcius' do
    it 'returns a success celcius temperature' do
      allow(address_double).to receive(:latitude)
      allow(address_double).to receive(:longitude)
      allow(OpenWeather::Client).to receive(:new).and_return(client_double)
      allow(client_double).to receive(:one_call).and_return(weather_double)
      allow(weather_double).to receive(:[]).with('current').and_return(main_double)
      allow(main_double).to receive(:temp_f).and_return(80.29)
      c = WeatherCheckService.new(address_double).current_temp
      expect(c).to eq 80.29
    end
  end
end
