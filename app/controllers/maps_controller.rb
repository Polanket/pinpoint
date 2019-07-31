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
      create_user_groups
      redirect_to map_path(@map)
    else
      render :new
    end
  end

  private

  def create_user_groups
    users = params['map'][:user_id].drop(1)
    users << current_user.id
    users.each do |user|
    UserGroup.create(user_id:user.to_i, map: @map)
    end
  end

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
