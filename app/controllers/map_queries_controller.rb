class MapQueriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    authorize current_map

    @markers = GPClient.spots_by_query(params[:query], detail: true).map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng,
        infoWindow: render_to_string(partial: 'maps/info_window', locals: { spot: spot }),
        image_url: helpers.asset_url('new_location.png')
      }
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def marker_composer(map)
    ::Composers::Markers.new(map)
  end

  def current_map
    @map = Map.find(params[:map_id])
  end
end
