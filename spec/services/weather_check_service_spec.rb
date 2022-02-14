# frozen_string_literal: true

require 'rails_helper'

describe WeatherCheckService, type: :model do
  RSpec.shared_context("with cache", :with_cache) do
    let!(:address_double) { double }
    let!(:client_double) { double }
    let!(:weather_double) { double }
    let!(:main_double) { double }
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
    before do
      allow(Rails).to receive(:cache).and_return(memory_store)
      Rails.cache.clear
    end

    describe '#current_temp' do
      it 'returns a success temperature' do
      end
      allow(address_double).to receive(:latitude)
      allow(address_double).to receive(:longitude)
      allow(address_double).to receive(:postal_code)
      allow(OpenWeather::Client).to receive(:new).and_return(client_double)
      allow(client_double).to receive(:one_call).and_return(weather_double)
      allow(weather_double).to receive(:[]).with('current').and_return(main_double)
      allow(main_double).to receive(:temp_f).and_return(80.29)
      c = WeatherCheckService.new(address_double).current_temp
      expect(c).to eq 80.29
    end
  end
end
