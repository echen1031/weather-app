# frozen_string_literal: true

class HomeController < ApplicationController
  require 'street_address'
  before_action :validate_address, only: [:check_weather]
  helper_method :zipcode, :display_address

  def index
  end

  # check weather with OpenWeather Client
  def check_weather
    if @zipcode.present?
      @weather = WeatherCheckService.new(@zipcode)
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
    google_address = Geocoder.search(params[:input_address][:address])
    @display_address = google_address[0].formatted_address
    @zipcode = google_address[0].postal_code
  end

  attr_reader :zipcode, :result
end
