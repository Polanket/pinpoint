import mapboxgl from 'mapbox-gl';
import markerIcon from '../images/added_location.png';
import { initNav } from './init_sidebar';

const popupOptions = {
  maxWidth: '300px'
}
// Places markers received from maps controller (checks if multiple markers or single lat lng combination)
const placeMarkers = (map, markers) => {
  if (Array.isArray(markers) && markers) {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup(popupOptions).setHTML(marker.infoWindow);
      const custom_marker = customMarker(marker)
      new mapboxgl.Marker(custom_marker)
        .setLngLat([ marker.lng, marker.lat])
        .addTo(map)
        .setPopup(popup)
        .addTo(map);
    });
  } else {
    const popup = new mapboxgl.Popup(popupOptions).setHTML(markers.infoWindow);
    const custom_marker = customMarker(markers);
    new mapboxgl.Marker(custom_marker)
      .setLngLat([ markers.lng, markers.lat ])
      .addTo(map)
      .setPopup(popup)
      .addTo(map);

    map.flyTo({
      center: [ markers.lng, markers.lat ],
      zoom: 14
    });
  }
};

const placeAddedMarker = (map, markers) => {
  const popup = new mapboxgl.Popup(popupOptions).setHTML(markers.infoWindow);
  const custom_marker = customMarker(markers);
  new mapboxgl.Marker(custom_marker)
    .setLngLat([ markers.lng, markers.lat ])
    .addTo(map)
    .setPopup(popup)
    .addTo(map);
}

// Adds button to get user location
const postionButton = (map) => {
  map.addControl(new mapboxgl.GeolocateControl({
    positionOptions: {
      enableHighAccuracy: true
    },
    trackUserLocation: false
  }));
};

// Applies zoom and center to fit markers
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

// Creates the custom marker html element
const customMarker = (marker) => {
  const element = document.createElement('div');
  element.className = 'custom_marker';
  element.style.backgroundImage = `url('${marker.image_url || markerIcon}')`;
  element.style.backgroundSize = 'contain';
  element.style.backgroundRepeat = 'no-repeat';
  element.style.width = '42.5px';
  element.style.height = '60px';
  return element;
}

const initMapbox = () => {
  initNav();
  const mapDiv = document.getElementById('map');
  if (mapDiv) {
    const markers = JSON.parse(mapDiv.dataset.markers);

    mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
    window.map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/light-v9',
    });

    map.flyTo({
      center: [ -3.707398, 40.415363 ],
      zoom: 14
    })

    postionButton(map)

    if (markers && markers !== 'null') {
      placeMarkers(map, markers);

      fitMapToMarkers(map, markers);
    }
  }
};

export { initMapbox, placeMarkers, placeAddedMarker };
