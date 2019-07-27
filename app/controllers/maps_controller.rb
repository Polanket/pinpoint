class MapsController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

  def show
    @map = params[:id].present? ? current_map : current_user.owned_maps.first_or_create(name: "#{current_user.name}'s map")
    composer = marker_composer(@map)
    @markers = composer.compose
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

  def current_map
    @map = Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:name, :description, :photo, :query)
  end
end
