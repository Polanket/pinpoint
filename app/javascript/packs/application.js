import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox, placeMarkers, placeAddedMarker } from '../plugins/init_mapbox';

import { initNav } from '../plugins/init_sidebar';

import { initSelect2 } from '../plugins/init_select2';

// import { animateMarkers } from '../plugins/init_markerAnimation';

// import '../plugins/search_box';

window.mapbox = initMapbox;

window.placeMarkers = placeMarkers;

window.placeAddedMarker = placeAddedMarker;

initMapbox();

initNav();

initSelect2();

// animateMarkers();
