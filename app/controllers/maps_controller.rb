class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]
  before_action :my_maps, only: [:show, :results]
  before_action :shared_maps, only: [:show, :results]

  def show
    @map = params[:id].present? ? current_map : current_user.owned_maps.first_or_create(name: "#{current_user.name}'s map")
    composer = marker_composer(@map)
    @markers = composer.compose
  end

  def results
    authorize current_map

    @markers = GPClient.spots_by_query(params[:query]).map do |spot|
      {
        lat: spot.lat,
        lng: spot.lng,
        infoWindow: render_to_string(partial: 'info_window', locals: { spot: spot }),
        image_url: helpers.asset_url('new_location.png')
      }
    end
    own_markers = marker_composer(current_map).compose
    own_markers.each do |location|
      @markers << location
    end
  end

  def save_marker
    authorize current_map
    location = GPClient.spot(params[:marker_id])
    AddedLocation.create(
      map_id: current_map.id,
      name: location.name,
      address: location.formatted_address,
      description: "Placeholder description",
      photo: location.photos[0].fetch_url(800),
      latitude: location.lat,
      longitude: location.lng
    )
    redirect_to map_path
  end


  def new
    @map = Map.new
    authorize @map
  end

  def create
    @map = Map.new(map_params)
    @map.user = current_user
    authorize @map
    if @map.save
      redirect_to new_map_user_group_path(@map)
    else
      render :new
    end
  end

  private

  def marker_composer(map)
    ::Composers::Markers.new(map)
  end

  def my_maps
    @my_maps = current_user.owned_maps
  end

  def shared_maps
    @shared_maps = current_user.shared_maps
  end

  def current_map
    @map = Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:name, :description, :photo, :query)
  end
end
