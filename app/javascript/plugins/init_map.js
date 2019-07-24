// Require google maps module
const loadGoogleMapsApi = require('load-google-maps-api');

const mapDiv = document.getElementById('map');
const input = document.getElementById('search-box');

const options = {
  key: process.env.GOOGLE_API_KEY,
  libraries: ['places']
};

const initSearchBox = (element, gMapApi, map) => {
  const searchBox = new gMapApi.places.SearchBox(element);
  map.controls[gMapApi.ControlPosition.BOTTOM_CENTER].push(element);
  map.addListener('bounds_changed', () => {
    searchBox.setBounds(map.getBounds());
  })
}

const initSearch = (search) => {
  const places = new googleMaps.places.PlacesService(map);

  places.findPlaceFromQuery(search, (results, status) => {
    if (status === googleMaps.places.PlacesServiceStatus.OK) {
      map.setCenter(results[0].geometry.location);
    }
  });
}

const callMapAPI = (lat=40.4168, lng=-3.7038) => {
  loadGoogleMapsApi(options)
    .then((googleMaps) => {
      const map = new googleMaps.Map(mapDiv, {
        center: {
          lat: lat,
          lng: lng
        },
        zoom: 16,
        disableDefaultUI: true
    });
      initSearchBox(input, googleMaps, map);

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
