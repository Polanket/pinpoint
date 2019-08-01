const animateMarkers = () => {
  const markers = document.querySelectorAll('.custom_marker');

  if (markers) {
    markers.forEach( marker => marker.classList.add('mapboxl-marker', 'animated', 'bounceInDown'));
  };
};

export { animateMarkers };
