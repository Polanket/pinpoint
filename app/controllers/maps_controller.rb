class MapsController < ApplicationController
  def index
    @maps = policy_scope(Map)
    @client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])

    @markers = @client.spots_by_query('goiko grill near madrid').map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng
      }
    end
  end

  def add_location
  end
end
