# frozen_string_literal: true

class HomeController < ApplicationController
  require 'street_address'
  before_action :validate_address, only: [:check_weather]
  helper_method :zipcode, :display_address

  def index
  end

  # check weather with OpenWeather Client
  def check_weather
    if @address_service.postal_code.present?
      @weather_service = WeatherCheckService.new(@address_service)
      respond_to do |format|
        format.js { render action: 'index' }
      end
    else
      flash[:error] = 'The Address entered is invalid. Please enter a valid address'
      redirect_to root_path
    end
  end

  # validate address with Geocoder
  def validate_address
    @address_service = AddressCheckService.new(params[:input_address][:address])
  end

  attr_reader :address_service
end
