App.global_maps = App.cable.subscriptions.create({
  channel: "MapsChannel",
  map_id: document.getElementById('map_id').value
}, {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    placeAddedMarker(window.map, data.marker);
    return console.log(data);
  },
  send_marker: function(marker, map_id) {
    return this.perform('send_marker', {
      marker: marker,
      map_id: map_id
    });
  }
});
