const animateMarkers = () => {
  const markers = document.querySelectorAll('.custom_marker');

  if (markers) {
    markers.forEach( marker => marker.classList.add('animated', 'bounceInDown'));
  };
};

export { animateMarkers };
