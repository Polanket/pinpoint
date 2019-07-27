class MapsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "maps_#{params['map_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_marker(data)
    Map.find(data['map_id'])
  end
end
