// Require google maps module
const loadGoogleMapsApi = require('load-google-maps-api');

let map;
let autocomplete;
let infoWindow;
let marker;


const mapDiv = document.getElementById('map');
const input = document.getElementById('searchTextField');
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
    disableDefaultUI: true
  });
};

// initAutocomplete creates the autocomplete object that will fill our input with the results
const initAutocomplete = (mapObject, map, inputElement) => {
  autocomplete = new mapObject.places.Autocomplete(inputElement);
  const places = new mapObject.places.PlacesService(map);
  autocomplete.bindTo('bounds', map);
  autocomplete.setFields(['address_components', 'geometry', 'icon', 'name']);
};

// initInfoWindow creates the card with the place's information
const initInfoWindow = (mapObject) => {
  infoWindow = new mapObject.InfoWindow()
  infoWindow.setContent(infowindowContent);
};

// initMarkers creates markers using the details from the search result
const initMarkers = (mapObject, map) => {
  marker = new mapObject.Marker({
    map: map,
    anchorPoint: new mapObject.Point(0, -29)
  });
};

// getPlace will show the place chosen from the dropdown
const getPlace = () => {
  autocomplete.addListener('place_changed', () => {
    infoWindow.close();
    marker.setVisible(false);
    const place = autocomplete.getPlace();
      if (!place.geometry) {
        // User entered the name of a Place that was not suggested and
        // pressed the Enter key, or the Place Details request failed.
        window.alert("Please specify a single location");
        return;
      };

      // If the place has a geometry, then present it on a map.
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);  // Why 17? Because it looks good.
      }
      marker.setPosition(place.geometry.location);
      marker.setVisible(true);

      let address = '';
        if (place.address_components) {
          address = [
            (place.address_components[0] && place.address_components[0].short_name || ''),
            (place.address_components[1] && place.address_components[1].short_name || ''),
            (place.address_components[2] && place.address_components[2].short_name || '')
          ].join(' ');
        };

      infowindowContent.children['place-icon'].src = place.icon;
      infowindowContent.children['place-name'].textContent = place.name;
      infowindowContent.children['place-address'].textContent = address;
      infoWindow.open(map, marker);
  });
};

// callMapAPI will call the google maps api
const callMapAPI = () => {
  loadGoogleMapsApi(options)
    .then((googleMaps) => {
      generateMap(googleMaps);

      initAutocomplete(googleMaps, map, input);

      initInfoWindow(googleMaps);

      initMarkers(googleMaps, map);

      getPlace();

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
