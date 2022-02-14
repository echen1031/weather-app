# frozen_string_literal: true

require 'rails_helper'

describe AddressCheckService, type: :model do
  before(:each) do
    # Stubbed out address for geocoder
    Geocoder.configure(:lookup => :test)
  end

  describe '#formatted_address' do
    it 'returns a success celcius temperature' do
      service = AddressCheckService.new('One Apple Park Way. Cupertino, CA 95014')
      expect(service).to respond_to(:formatted_address)
      expect(service).to respond_to(:longitude)
      expect(service).to respond_to(:latitude)
      expect(service).to respond_to(:postal_code)
    end
  end
end
