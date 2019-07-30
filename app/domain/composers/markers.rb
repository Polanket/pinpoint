module Composers
  class Markers
    include AbstractController::Rendering
    attr_reader :map

    def initialize(map)
      @map = map
    end

    def compose
      generate_view_data
    end

    def compose_marker(added_location)
      parse_locations(added_location)
    end

    private

    def generate_view_data
      added_locations.map { |location| parse_locations(location) }
    end

    def added_locations
      @_added_locations||= map.added_locations
    end

    def parse_locations(added_location)
      { lat: added_location.latitude,
        lng: added_location.longitude,
        infoWindow: ApplicationController.render(partial: 'maps/added_info_window', locals: { spot: added_location }) }
    end
  end
end
