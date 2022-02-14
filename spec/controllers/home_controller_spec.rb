# frozen_string_literal: true

require 'rails_helper'

describe HomeController, type: :controller do
  let!(:address_double) { double }
  let!(:service_double) { double }
  before(:each) do
    # Stubbed out address for geocoder
    Geocoder.configure(:lookup => :test)
  end
  render_views

  let(:valid_address) do
    { address: 'One Apple Park Way. Cupertino, CA 95014' }
  end

  let(:invalid_address) do
    { address: '' }
  end

  context 'Valid address' do
    describe 'POST #check_weather' do
      it 'returns a success response' do
        allow(WeatherCheckService).to receive(:new)
          .and_return(service_double)
        allow(service_double).to receive(:current_temp).and_return(80.29)
        allow(service_double).to receive(:low_temp)
        allow(service_double).to receive(:high_temp)
        allow(service_double).to receive(:extended_forecast)
        allow(service_double).to receive(:cached?)
        post :check_weather, params: { input_address: valid_address }, xhr: true
        expect(response).to be_successful
        expect(response.body).to include("80.29")
      end
    end
  end

  context 'Invalid address' do
    describe 'POST #check_weather' do
      it 'returns a success response' do
        post :check_weather, params: { input_address: invalid_address }, xhr: true
        expect(flash[:error].present?).to eq true
      end
    end
  end
end
