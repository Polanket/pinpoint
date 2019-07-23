// Require google maps module
const loadGoogleMapsApi = require('load-google-maps-api');

const mapDiv = document.getElementById('map');
const options = {
  key: process.env.GOOGLE_API_KEY
};

const callMapAPI = (lat=40.4168, lng=-3.7038) => {
  loadGoogleMapsApi(options)
    .then((googleMaps) => {
      new googleMaps.Map(mapDiv, {
        center: {
          lat: lat,
          lng: lng
        },
        zoom: 12
    })
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
