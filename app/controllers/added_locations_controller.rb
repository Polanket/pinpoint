class AddedLocationsController < ApplicationController
  def create
    authorize current_map
    location = GPClient.spot(params[:marker_id])
    current_map
      .added_locations
      .where(latitude: location.lat, longitude: location.lng)
      .first_or_create(
        name: location.name,
        address: location.formatted_address,
        url: location.url,
        phone_number: location.phone_number,
        types: location.types,
        photo: location.photos
      )
    @markers = marker_composer(current_map).compose
  end

  def show
    @location = AddedLocation.find(params[:id])
    raise
  end

  private

  def marker_composer(map)
    ::Composers::Markers.new(map)
  end

  def current_map
    @map = Map.find(params[:id])
  end
end
