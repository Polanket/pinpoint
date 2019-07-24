import mapboxgl from 'mapbox-gl';

// Places markers received from maps controller (checks if multiple markers or single lat lng combination)
const placeMarkers = (map, markers) => {
  console.log(markers)
  if (Array.isArray(markers)) {
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat])
        .addTo(map);
    });

  } else {
    new mapboxgl.Marker()
      .setLngLat([ markers.lng, markers.lat ])
      .addTo(map);

    map.flyTo({
      center: [ markers.lng, markers.lat ],
      zoom: 14
    })
  }
};

// Applies zoom and center to fit markers
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapDiv = document.getElementById('map');
  const markers = JSON.parse(mapDiv.dataset.markers);

  if (mapDiv) {
    mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v9'
    });

    placeMarkers(map, markers);

    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };
