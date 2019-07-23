



const createMap = (lat=3, lng=3) => {
  const mapDiv = document.getElementById('map');

  const loadGoogleMapsApi = require('load-google-maps-api');
  const options = {
    key: "AIzaSyBg61RkoahSbdIJfvy9a7EpBP2OWz5PdHE"
  };
 if (mapDiv) {
    loadGoogleMapsApi(options)
      .then((googleMaps) => {
        new googleMaps.Map(mapDiv, {
          center: {
            lat: lat,
            lng: lng
          },
          zoom:12
        });
    }).catch(error => console.log(error));
  }
}

const initMap = () => {

  // console.log(loadGoogleMapsApi)
  // console.log(mapDiv)
  // console.log(options)
// if user passes location
// call the

  // if ("geolocation" in navigator) {
  //   navigator.geolocation.getCurrentPosition((position) => {
  //     console.log(position)
  //     const userLocation = {
  //       latitude: position.coords.latitude,
  //       longitude: position.coords.longitude
  //     };
  //     return userLocation;
  //   });
  // }








createMap()
}

export { initMap };
