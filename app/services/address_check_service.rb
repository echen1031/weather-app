# frozen_string_literal: true

class AddressCheckService
  ADDRESS_METHODS = ['formatted_address', 'longitude', 'latitude', 'postal_code']
  attr_reader :google_address

  # constructor
  def initialize(address_param)
    @google_address = Geocoder.search(address_param)[0]
  end

  # access various methods on google_address object
  ADDRESS_METHODS.each do |method|
    define_method "#{method}" do
      return nil unless google_address.present?

      google_address.send(method.to_s)
    end
  end
end
