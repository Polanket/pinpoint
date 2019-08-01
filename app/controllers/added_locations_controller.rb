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
        description: 'Placeholder description',
        phone_number: location.formatted_phone_number,
        types: location.types,
        photo: location.photos.map { |photo| photo.fetch_url(400) }
      )
    @markers = marker_composer(current_map).compose
  end

  def show
    @map = Map.find(params[:map_id])
    authorize added_location
    @review = Review.new
  end

  private

  def added_location
    @location = AddedLocation.find(params[:id])
  end

  def marker_composer(map)
    ::Composers::Markers.new(map)
  end

  def current_map
    @map = Map.find(params[:id])
  end
end
