class MapMarkerNotificationJob < ApplicationJob
  queue_as :default

  def perform(added_location)
    ActionCable.server.broadcast "maps_#{added_location.map.id}_channel",
                                marker: marker_composer(added_location.map).compose_marker(added_location)
  end

  private

  def marker_composer(map)
    ::Composers::Markers.new(map)
  end
end
