class MapQueriesController < ApplicationController
  def create
    authorize current_map

    @markers = GPClient.spots_by_query(params[:query], multipage: true).map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng,
        infoWindow: render_to_string(partial: 'maps/info_window', locals: { spot: spot }),
        image_url: helpers.asset_url('new_location.png')
      }
    end
    # own_markers = marker_composer(current_map).compose
    # own_markers.each do |location|
    #   @markers << location
    # end
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
