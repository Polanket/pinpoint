// Require google maps module
const loadGoogleMapsApi = require('load-google-maps-api');

let map;
let infoWindow;
let marker;

const mapDiv = document.getElementById('map');
const input = document.getElementById('searchTextField')
const infowindowContent = document.getElementById('infowindow-content');

// Options for the load-google-maps-api request
const options = {
  key: process.env.GOOGLE_API_KEY,
  libraries: ['places']
};

// generateMap creates a map with a default center in madrid
const generateMap = (mapObject, lat=40.4168, lng=-3.7038) => {
  map = new mapObject.Map(mapDiv, {
    center: {
      lat: lat,
      lng: lng
    },
    zoom: 16,
    disableDefaultUI: false
  });
};

// initInfoWindow creates the card with the place's information
const initInfoWindow = (mapObject) => {
  infoWindow = new mapObject.InfoWindow()
  infoWindow.setContent(infowindowContent);
};

// Set markers
const initMarkers = (mapObject, map) => {
  console.log(JSON.parse(mapDiv.dataset.markers))
  const markers = JSON.parse(mapDiv.dataset.markers);
  console.log(markers)
  markers.forEach((marker) => {
    new mapObject.Marker({
      position: {
        lat: marker.lat,
        lng: marker.lng
      },
      map: map,
    });
  });
}

// callMapAPI will call the google maps api
const callMapAPI = () => {
  loadGoogleMapsApi(options)
    .then((googleMaps) => {
      generateMap(googleMaps);

      initInfoWindow(googleMaps);

      initMarkers(googleMaps, map);

      const search = {
        query: input.value,
        fields: ['name', 'geometry']
      };

  }).catch(error => console.log(error));
};

const initMap = () => {
  if (mapDiv) {
    if ("geolocation" in navigator) {
      navigator.geolocation.getCurrentPosition((position) => {
        console.log(position);
        callMapAPI(position.coords.latitude, position.coords.longitude);
      }, (error => console.log(error)));
    }
    callMapAPI();
  };
}

export { initMap };
